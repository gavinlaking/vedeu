require 'test_helper'

module Vedeu

  module Input

    describe Capture do

      let(:reader)    { Vedeu::Terminal }
      let(:keypress)  { 'a' }
      let(:described) { Vedeu::Input::Capture }
      let(:instance)  { described.new(reader) }
      let(:raw_mode)  { true }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@reader').must_equal(reader) }
      end

      describe '.read' do
        before do
          reader.stubs(:raw_mode?).returns(raw_mode)
          reader.stubs(:fake_mode?).returns(fake_mode)
          Vedeu.stubs(:trigger).returns([false])
        end

        subject { described.read(reader) }

        context 'when in cooked mode' do
          let(:raw_mode)  { false }
          let(:fake_mode) { false }
          let(:command)   { 'help' }

          before { reader.stubs(:read).returns(command) }

          it 'triggers an event with the command' do
            Vedeu.expects(:trigger).with(:_command_, command)
            subject
          end
        end

        context 'when in fake mode' do
          let(:raw_mode)  { false }
          let(:fake_mode) { true }
          let(:keypress)  { 'b' }

          before { reader.stubs(:read).returns(keypress) }

          context 'when an interface or view has been registered' do
            let(:interface_name) { :fake_interface }
            let(:interface)      {
              Vedeu::Interfaces::Interface.new(name: interface_name, editable: editable)
            }
            let(:editable)       { false }
            let(:registered)     { false }

            before do
              Vedeu.stubs(:focus).returns(interface_name)
              Vedeu.interfaces.stubs(:by_name).with(interface_name).returns(interface)
              Vedeu::Input::Mapper.expects(:registered?).with(keypress, interface_name).returns(registered)
            end

            context 'when the keypress is registered with the keymap' do
              let(:registered) { true }

              it 'triggers an event with the keypress' do
                Vedeu.expects(:trigger).with(:_keypress_, keypress, interface_name)
                subject
              end
            end

            context 'when the keypress is not registered with the keymap' do
              let(:registered) { false }

              context 'when the interface or view is editable' do
                let(:editable) { true }

                it 'triggers an event with the keypress' do
                  Vedeu.expects(:trigger).with(:_editor_, keypress)
                  subject
                end
              end

              context 'when the interface or view is not editable' do
                let(:editable) { false }

                it 'triggers an event with the keypress' do
                  Vedeu.expects(:trigger).with(:key, keypress)
                  subject
                end
              end
            end
          end

          # context 'when no interfaces or views have been registered' do
          #   before {
          #     Vedeu.focus.reset
          #     Vedeu.interfaces.reset
          #   }

          #   it { proc { subject }.must_raise(Vedeu::Error::Fatal) }
          # end
        end

        context 'when in raw mode' do
          let(:raw_mode)  { true }
          let(:fake_mode) { false }
          let(:keypress)  { 'a' }

          before { reader.stubs(:read).returns(keypress) }

          context 'when the key is not special' do
            it 'triggers an event with the keypress' do
              Vedeu.expects(:trigger).with(:_keypress_, keypress)
              subject
            end
          end

          context 'when the key is special' do
            let(:keypress) { "\e[A" }

            it 'triggers an event with the keypress' do
              Vedeu.expects(:trigger).with(:_keypress_, :up)
              subject
            end

            context 'when the key is an F key' do
              let(:keypress) { "\e[17~" }

              it 'triggers an event with the keypress' do
                Vedeu.expects(:trigger).with(:_keypress_, :f6)
                subject
              end
            end
          end
        end
      end

    end # Input

  end # Input

end # Vedeu

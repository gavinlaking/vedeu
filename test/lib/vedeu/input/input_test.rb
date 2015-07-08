require 'test_helper'

module Vedeu

  describe Input do

    let(:reader)    { Vedeu::Terminal }
    let(:keypress)  { 'a' }
    let(:described) { Vedeu::Input }
    let(:instance)  { described.new(reader) }
    let(:raw_mode)  { true }

    before do
      reader.stubs(:raw_mode?).returns(raw_mode)
      Vedeu.stubs(:trigger).returns([false])
    end

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
      it { instance.instance_variable_get('@reader').must_equal(reader) }
    end

    describe '.capture' do
      subject { described.capture(reader) }

      context 'when in cooked mode' do
        let(:raw_mode) { false }
        let(:command)  { 'help' }

        before { reader.stubs(:read).returns(command) }

        it 'triggers an event with the command' do
          Vedeu.expects(:trigger).with(:_command_, command)
          subject
        end
      end

      context 'when in raw mode' do
        let(:raw_mode) { true }
        let(:keypress) { 'a' }

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

end # Vedeu

require 'test_helper'

module Vedeu

  module Input

    describe Read do

      let(:described) { Vedeu::Input::Read }
      let(:instance)  { described.new(input, options) }
      let(:input)     {}
      let(:options)   {
        {
          mode: mode
        }
      }
      let(:mode) { :cooked }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@input').must_equal(input) }
        it { instance.instance_variable_get('@options').must_equal(options) }
      end

      describe '.read' do
        subject { described.read(input, options) }

        context 'when the mode is :cooked' do
          context 'when input was given' do
            let(:input) { 'Some text...' }

            it {
              Vedeu.expects(:trigger).with(:_command_, input)
              subject
            }
          end

          context 'when input was not given' do
            let(:some_input) { "Some text...\n" }
            let(:chomped)    { 'Some text...' }

            it {
              Vedeu::Terminal.console.expects(:gets).returns(some_input)
              Vedeu.expects(:trigger).with(:_command_, chomped)
              subject
            }
          end
        end

        context 'when the mode is :raw' do
          let(:mode) { :raw }

          context 'when input was given' do
            let(:input) { 'S' }

            it {
              Vedeu.expects(:trigger).with(:_keypress_, input)
              subject
            }
          end

          context 'when input was not given' do
            let(:some_input) { 'T' }
            let(:translated) { 'T' }

            it {
              Vedeu::Terminal.console.expects(:getch).returns(some_input)
              Vedeu::Input::Translator.expects(:translate).returns(translated)
              Vedeu.expects(:trigger).with(:_keypress_, translated)
              subject
            }

            context 'but a special key is pressed' do
              let(:some_input) { "\e[23;2~" }
              let(:translated) { :shift_f11 }

              it {
                Vedeu::Terminal.console.expects(:getch).returns(some_input)
                Vedeu::Input::Translator.expects(:translate).returns(translated)
                Vedeu.expects(:trigger).with(:_keypress_, translated)
                subject
              }
            end
          end
        end

        context 'when the mode is invalid' do
          let(:mode) { :invalid }

          it { proc { subject }.must_raise(Vedeu::Error::InvalidSyntax) }
        end
      end

      describe '#read' do
        it { instance.must_respond_to(:read) }
      end

    end # Read

  end # Input

end # Vedeu

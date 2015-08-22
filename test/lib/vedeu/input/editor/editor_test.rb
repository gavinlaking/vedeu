require 'test_helper'

module Vedeu

  module Editor

    describe Editor do

      let(:described) { Vedeu::Editor::Editor }
      let(:instance)  {
        described.new(input: input, name: _name)
      }
      let(:input)     {}
      let(:_name)     { 'Vedeu::Editor::Editor' }
      let(:document)  { Vedeu::Editor::Document.new(data: data, name: _name) }
      let(:data)      {
        "Hydrogen\n"  \
        "Helium\n"    \
        "Lithium\n"   \
        "Beryllium\n" \
        "Boron\n"     \
        "Carbon\n"    \
        "Nitrogen\n"  \
        "Oxygen\n"    \
        "Fluorine\n"  \
        "Neon\n"      \
        "Sodium\n"    \
        "Magnesium"
      }

      before do
        Vedeu.documents.stubs(:by_name).returns(document)
      end

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@input').must_equal(input) }
        it { instance.instance_variable_get('@name').must_equal(_name) }
      end

      describe '.keypress' do
        subject { described.keypress(input: input, name: _name) }

        context 'when no name is given' do
          let(:document) {}

          it 'returns the input instead of sending to the document' do
            subject.must_equal(input)
          end
        end

        context 'when a name is given' do
          context 'when the input is :backspace' do
            let(:input) { :backspace }

            it {
              document.expects(:delete_character)
              subject
            }
          end

          context 'when the input is :ctrl_c' do
            let(:input) { :ctrl_c }

            it {
              Vedeu.expects(:trigger).with(:_exit_)
              subject
            }
          end

          context 'when the input is :down' do
            let(:input) { :down }

            it {
              document.expects(:down)
              subject
            }
          end

          context 'when the input is :enter' do
            let(:input) { :enter }

            it {
              document.expects(:insert_line)
              subject
            }
          end

          context 'when the input is :escape' do
            let(:input) { :escape }

            it {
              Vedeu.expects(:trigger).with(:_mode_switch_)
              subject
            }
          end

          context 'when the input is :left' do
            let(:input) { :left }

            it {
              document.expects(:left)
              subject
            }
          end

          context 'when the input is :right' do
            let(:input) { :right }

            it {
              document.expects(:right)
              subject
            }
          end

          context 'when the input is :up' do
            let(:input) { :up }

            it {
              document.expects(:up)
              subject
            }
          end

          context 'when the input is something else' do
            context 'when the input is a symbol' do
              let(:input) { :ctrl_p }

              it { subject.must_equal(nil) }
            end

            context 'when the input is not a symbol' do
              let(:input) { 'a' }

              it {
                document.expects(:insert_character).with(input)
                subject
              }
            end
          end
        end
      end

      describe '#keypress' do
        it { instance.must_respond_to(:keypress) }
      end

    end # Editor

  end # Editor

end # Vedeu

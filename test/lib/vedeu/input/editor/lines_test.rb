require 'test_helper'

module Vedeu

  module Editor

    describe Lines do

      let(:described) { Vedeu::Editor::Lines }
      let(:instance)  { described.new(text: text, y: y, x: x) }
      let(:text)      {
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
      let(:y)         {}
      let(:x)         {}

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@text').must_equal(text) }

        context 'when x is nil' do
          it { instance.instance_variable_get('@x').must_equal(0) }
        end

        context 'when x is not nil' do
          let(:x) { 3 }

          it { instance.instance_variable_get('@x').must_equal(3) }
        end

        context 'when y is nil' do
          it { instance.instance_variable_get('@y').must_equal(0) }
        end

        context 'when y is not nil' do
          let(:y) { 6 }

          it { instance.instance_variable_get('@y').must_equal(6) }
        end

        context 'when the text is empty' do
          let(:text) {}

          it { instance.instance_variable_get('@lines').must_equal([]) }
        end

        context 'when the text is not empty' do
          let(:expected) {
            [
              'Hydrogen', 'Helium', 'Lithium', 'Beryllium', 'Boron', 'Carbon',
              'Nitrogen', 'Oxygen', 'Fluorine', 'Neon', 'Sodium', 'Magnesium',
            ]
          }

          it { instance.instance_variable_get('@lines').must_equal(expected) }
        end
      end

      describe '#render' do
        subject { instance.render }

        it { subject.must_be_instance_of(String) }

        context 'when the text is empty' do
          let(:text) {}

          it { subject.must_equal('') }
        end

        context 'when the text is not empty' do
          it { subject.must_equal(text) }
        end
      end

      describe '#y_position' do
        subject { instance.y_position }

        it { subject.must_be_instance_of(Fixnum) }

        context 'when y is nil or y <= 0' do
          it { subject.must_equal(0) }

          context 'and y is moved up' do
            it {
              instance.send(:up)
              subject.must_equal(0)
            }

            it 'multiple times' do
              instance.send(:up)
              instance.send(:up)

              subject.must_equal(0)
            end
          end

          context 'and y is moved down' do
            it {
              instance.send(:down)
              subject.must_equal(1)
            }

            it 'multiple times' do
              instance.send(:down)
              instance.send(:down)

              subject.must_equal(2)
            end
          end
        end

        context 'when y > 0 && y <= size - 1' do
          let(:y) { 4 }

          it { subject.must_equal(4) }

          context 'and y is moved up' do
            it {
              instance.send(:up)
              subject.must_equal(3)
            }

            it 'multiple times' do
              instance.send(:up)
              instance.send(:up)

              subject.must_equal(2)
            end
          end

          context 'and y is moved down' do
            it {
              instance.send(:down)
              subject.must_equal(5)
            }

            it 'multiple times' do
              instance.send(:down)
              instance.send(:down)

              subject.must_equal(6)
            end
          end
        end

        context 'when y > size - 1' do
          let(:y) { 15 }

          it { subject.must_equal(11) }

          context 'and y is moved up' do
            it {
              instance.send(:up)
              subject.must_equal(10)
            }

            it 'multiple times' do
              instance.send(:up)
              instance.send(:up)

              subject.must_equal(9)
            end
          end

          context 'and y is moved down' do
            it {
              instance.send(:down)
              subject.must_equal(11)
            }

            it 'multiple times' do
              instance.send(:down)
              instance.send(:down)

              subject.must_equal(11)
            end
          end
        end
      end

    end # Lines

  end # Editor

end # Vedeu

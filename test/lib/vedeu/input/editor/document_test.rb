require 'test_helper'

module Vedeu

  module Editor

    describe Document do

      let(:described) { Vedeu::Editor::Document }
      let(:instance)   { described.new(attributes) }
      let(:attributes) {
        {
          data: data,
          name: _name,
          x:    x,
          y:    y,
        }
      }
      let(:data)   {
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
      let(:_name)  { 'Vedeu::Editor::Document' }
      let(:x)      {}
      let(:y)      {}
      let(:border) { Vedeu::Border.new(name: _name) }

      before do
        Vedeu.borders.stubs(:by_name).with(_name).returns(border)
      end

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@data').must_equal(data) }
        it { instance.instance_variable_get('@name').must_equal(_name) }
        it {
          instance.instance_variable_get('@repository').
            must_equal(Vedeu.documents)
        }

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

        it { instance.instance_variable_get('@border').must_equal(border) }
      end

      describe 'accessors' do
        it { instance.must_respond_to(:attributes) }
        it { instance.must_respond_to(:data) }
        it { instance.must_respond_to(:data=) }
        it { instance.must_respond_to(:name) }
        it { instance.must_respond_to(:name=) }
      end

      describe '#delete_character' do
        context 'when the line is empty' do
          let(:data) {}

          it {
            instance.delete_character
            instance.line.must_equal('')
          }
        end

        context 'when the line is not empty' do
          context 'and x is nil or x <= 0' do
            let(:x) { 0 }

            it {
              instance.delete_character
              instance.line.must_equal('Hydrogen')
            }
          end

          context 'and x is at the last character of the line' do
            let(:x) { 7 }

            it {
              instance.delete_character
              instance.line.must_equal('Hydroge')
            }

            it 'handles multiple deletes' do
              instance.delete_character
              instance.delete_character
              instance.line.must_equal('Hydroe')
            end
          end

          context 'and x is somewhere on the line' do
            let(:x) { 4 }

            it {
              instance.delete_character
              instance.line.must_equal('Hydrgen')
            }

            it 'handles multiple deletes' do
              instance.delete_character
              instance.delete_character
              instance.line.must_equal('Hydgen')
            end
          end
        end
      end

      describe '#delete_line' do
        let(:y) { 4 }

        subject { instance.delete_line }

        context 'when there is no data' do
          let(:data) {}

          it { subject.data.must_equal('') }
        end

        context 'when there is data' do
          let(:expected) {
            "Hydrogen\n"  \
            "Helium\n"    \
            "Lithium\n"   \
            "Beryllium\n" \
            "Carbon\n"    \
            "Nitrogen\n"  \
            "Oxygen\n"    \
            "Fluorine\n"  \
            "Neon\n"      \
            "Sodium\n"    \
            "Magnesium"
          }

          it { subject.data.must_equal(expected) }
          it { subject.lines.wont_include('Boron') }
        end

        it { subject.must_be_instance_of(Vedeu::Editor::Document) }
      end

      describe '#down' do
        subject { instance.down }

        it { subject.must_be_instance_of(Vedeu::Editor::Document) }

        context 'when y = last line' do
          let(:y) { 11 }

          it 'y becomes the last line index' do
            subject.y.must_equal(11)
          end
        end

        context 'when y > last line' do
          let(:y) { 13 }

          it 'y becomes the last line index' do
            subject.y.must_equal(11)
          end
        end

        context 'when y < last line' do
          let(:y) { 4 }

          it {
            subject.y.must_equal(5)
          }
        end
      end

      describe '#insert_character' do
        let(:character) { 'a' }

        context 'when the line is empty' do
          let(:data) {}

          it {
            instance.insert_character(character)
            instance.line.must_equal('a')
          }
        end

        context 'when the line is not empty' do
          context 'and x is at the last character of the line' do
            let(:x) { 7 }

            it {
              instance.insert_character('Hydrogena')
            }

            it 'handles multiple inserts' do
              instance.insert_character(character)
              instance.insert_character(character)
              instance.line.must_equal('Hydrogenaa')
            end
          end

          context 'and x is somewhere on the line' do
            let(:x) { 4 }

            it {
              instance.insert_character(character)
              instance.line.must_equal('Hydraogen')
            }

            it 'handles multiple inserts' do
              instance.insert_character(character)
              instance.insert_character(character)
              instance.line.must_equal('Hydraaogen')
            end
          end
        end
      end

      describe '#insert_line' do
        let(:y) { 4 }

        subject { instance.insert_line }

        context 'when there is no data' do
          let(:data) {}

          it { subject.data.must_equal('') }
        end

        context 'when there is data' do
          let(:expected) {
            "Hydrogen\n"  \
            "Helium\n"    \
            "Lithium\n"   \
            "Beryllium\n" \
            "Boron\n"     \
            "\n"          \
            "Carbon\n"    \
            "Nitrogen\n"  \
            "Oxygen\n"    \
            "Fluorine\n"  \
            "Neon\n"      \
            "Sodium\n"    \
            "Magnesium"
          }

          it { subject.data.must_equal(expected) }
        end

        it { subject.must_be_instance_of(Vedeu::Editor::Document) }
      end

      describe '#left' do
        subject { instance.left }

        it { subject.must_be_instance_of(Vedeu::Editor::Document) }

        context 'when x = 0' do
          let(:x) { 0 }

          it { subject.x.must_equal(0) }
        end

        context 'when x < 0' do
          let(:x) { -4 }

          it { subject.x.must_equal(0) }
        end

        context 'when x > last character' do
          let(:x) { 15 }

          it { subject.x.must_equal(6) }
        end

        context 'when x = last character' do
          let(:x) { 10 }

          it { subject.x.must_equal(6) }
        end

        context 'when x < last character' do
          let(:x) { 6 }

          it { subject.x.must_equal(5) }
        end
      end

      describe '#line' do
        subject { instance.line }

        context 'when the line is empty' do
          let(:data) {}

          it { subject.must_equal('') }
        end

        context 'when the line is not empty' do
          it { subject.must_equal('Hydrogen') }
        end
      end

      describe '#lines' do
        subject { instance.lines }

        context 'when the data is empty' do
          let(:data) {}

          it { subject.must_equal([]) }
        end

        context 'when the data is not empty' do
          let(:expected) {
            [
              'Hydrogen', 'Helium', 'Lithium', 'Beryllium', 'Boron', 'Carbon',
              'Nitrogen', 'Oxygen', 'Fluorine', 'Neon', 'Sodium', 'Magnesium',
            ]
          }

          it { subject.must_equal(expected) }
        end
      end

      describe '#new_line' do
        subject { instance.new_line }

        it {
          subject
          instance.x.must_equal(1)
          instance.y.must_equal(1)
        }
      end

      describe '#right' do
        subject { instance.right }

        it { subject.must_be_instance_of(Vedeu::Editor::Document) }

        context 'when x = last character' do
          let(:x) { 8 }

          it 'x becomes the last character index' do
            subject.x.must_equal(7)
          end
        end

        context 'when x > last character' do
          let(:x) { 10 }

          it 'x becomes the last character index' do
            subject.x.must_equal(7)
          end
        end

        context 'when x < last character' do
          let(:x) { 4 }

          it { subject.x.must_equal(5) }
        end
      end

      describe '#up' do
        subject { instance.up }

        it { subject.must_be_instance_of(Vedeu::Editor::Document) }

        context 'when y = 0' do
          let(:y) { 0 }

          it { subject.y.must_equal(0) }
        end

        context 'when y < 0' do
          let(:y) { -4 }

          it { subject.y.must_equal(0) }
        end

        context 'when y > last line' do
          let(:y) { 15 }

          it { subject.y.must_equal(10) }
        end

        context 'when y = last line' do
          let(:y) { 10 }

          it { subject.y.must_equal(9) }
        end

        context 'when y < last line' do
          let(:y) { 6 }

          it { subject.y.must_equal(5) }
        end
      end

      describe '#x' do
        subject { instance.x }

        it { subject.must_be_instance_of(Fixnum) }

        context 'when x is nil or x <= 0' do
          it { subject.must_equal(0) }

          context 'and x is moved left' do
            it {
              instance.left
              subject.must_equal(0)
            }

            it 'multiple times' do
              instance.left
              instance.left

              subject.must_equal(0)
            end
          end

          context 'and x is moved right' do
            it {
              instance.right
              subject.must_equal(1)
            }

            it 'multiple times' do
              instance.right
              instance.right

              subject.must_equal(2)
            end
          end
        end

        context 'when x > 0 && x <= line_size - 1' do
          let(:x) { 4 }

          it { subject.must_equal(4) }

          context 'and x is moved left' do
            it {
              instance.left
              subject.must_equal(3)
            }

            it 'multiple times' do
              instance.left
              instance.left

              subject.must_equal(2)
            end
          end

          context 'and x is moved right' do
            it {
              instance.right
              subject.must_equal(5)
            }

            it 'multiple times' do
              instance.right
              instance.right

              subject.must_equal(6)
            end
          end
        end

        context 'when x > size - 1' do
          let(:x) { 10 }

          it { subject.must_equal(7) }

          context 'and x is moved left' do
            it {
              instance.left
              subject.must_equal(6)
            }

            it 'multiple times' do
              instance.left
              instance.left

              subject.must_equal(5)
            end
          end

          context 'and x is moved right' do
            it {
              instance.right
              subject.must_equal(7)
            }

            it 'multiple times' do
              instance.right
              instance.right

              subject.must_equal(7)
            end
          end
        end
      end

      describe '#y' do
        subject { instance.y }

        it { subject.must_be_instance_of(Fixnum) }

        context 'when y is nil or y <= 0' do
          it { subject.must_equal(0) }

          context 'and y is moved up' do
            it {
              instance.up
              subject.must_equal(0)
            }

            it 'multiple times' do
              instance.up
              instance.up

              subject.must_equal(0)
            end
          end

          context 'and y is moved down' do
            it {
              instance.down
              subject.must_equal(1)
            }

            it 'multiple times' do
              instance.down
              instance.down

              subject.must_equal(2)
            end
          end
        end

        context 'when y > 0 && y <= size - 1' do
          let(:y) { 4 }

          it { subject.must_equal(4) }

          context 'and y is moved up' do
            it {
              instance.up
              subject.must_equal(3)
            }

            it 'multiple times' do
              instance.up
              instance.up

              subject.must_equal(2)
            end
          end

          context 'and y is moved down' do
            it {
              instance.down
              subject.must_equal(5)
            }

            it 'multiple times' do
              instance.down
              instance.down

              subject.must_equal(6)
            end
          end
        end

        context 'when y > size - 1' do
          let(:y) { 15 }

          it { subject.must_equal(11) }

          context 'and y is moved up' do
            it {
              instance.up
              subject.must_equal(10)
            }

            it 'multiple times' do
              instance.up
              instance.up

              subject.must_equal(9)
            end
          end

          context 'and y is moved down' do
            it {
              instance.down
              subject.must_equal(11)
            }

            it 'multiple times' do
              instance.down
              instance.down

              subject.must_equal(11)
            end
          end
        end
      end


    end # Editor

  end # Editor

end # Vedeu

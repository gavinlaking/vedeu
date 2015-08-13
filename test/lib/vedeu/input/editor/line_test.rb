require 'test_helper'

module Vedeu

  module Editor

  	describe Line do

      let(:described) { Vedeu::Editor::Line }
      let(:instance)  { described.new(line: line, x: x) }
      let(:line)      { 'Some text...' }
      let(:x)         {}

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@line').must_equal(line) }

        context 'when x is nil' do
          it { instance.instance_variable_get('@x').must_equal(0) }
        end

        context 'when x is not nil' do
          let(:x) { 3 }

          it { instance.instance_variable_get('@x').must_equal(3) }
        end

        context 'when the line is empty' do
          let(:line) {}

          it { instance.instance_variable_get('@chars').must_equal([]) }
        end

        context 'when the line is not empty' do
          let(:expected) {
            ['S', 'o', 'm', 'e', ' ', 't', 'e', 'x', 't', '.', '.', '.']
          }

          it { instance.instance_variable_get('@chars').must_equal(expected) }
        end
      end

      describe '#delete' do
        subject { instance.delete }

        context 'when the line is empty' do
          let(:line) {}

          it {
            subject
            instance.render.must_equal('')
          }
        end

        context 'when the line is not empty' do
          context 'and x is nil or x <= 0' do
            it {
              subject
              instance.render.must_equal('Some text...')
            }
          end

          context 'and x is at the last character of the line' do
            let(:x) { 15 }

            it {
              subject
              instance.render.must_equal('Some text..')
            }

            it 'handles multiple deletes' do
              instance.delete
              instance.delete
              instance.render.must_equal('Some text.')
            end
          end

          context 'and x is somewhere on the line' do
            let(:x) { 8 }

            it {
              subject
              instance.render.must_equal('Some tex...')
            }

            it 'handles multiple deletes' do
              instance.delete
              instance.delete
              instance.render.must_equal('Some te...')
            end
          end
        end
      end

      describe '#insert' do
        let(:character) { 'a' }

        subject { instance.insert(character) }

        context 'when the line is empty' do
          let(:line) {}

          it {
            subject
            instance.render.must_equal('a')
          }
        end

        context 'when the line is not empty' do
          context 'and x is at the last character of the line' do
            let(:x) { 15 }

            it {
              subject
              instance.render.must_equal('Some text...a')
            }

            it 'handles multiple inserts' do
              instance.insert(character)
              instance.insert(character)
              instance.render.must_equal('Some text...aa')
            end
          end

          context 'and x is somewhere on the line' do
            let(:x) { 8 }

            it {
              subject
              instance.render.must_equal('Some texat...')
            }

            it 'handles multiple inserts' do
              instance.insert(character)
              instance.insert(character)
              instance.render.must_equal('Some texaat...')
            end
          end
        end
      end

      describe '#render' do
        subject { instance.render }

        it { subject.must_be_instance_of(String) }

        context 'when the line is empty' do
          let(:line) {}

          it { subject.must_equal('') }
        end

        context 'when the line is not empty' do
          it { subject.must_equal(line) }
        end
      end

      describe '#x_position' do
        subject { instance.x_position }

        it { subject.must_be_instance_of(Fixnum) }

        context 'when x is nil or x <= 0' do
          it { subject.must_equal(0) }

          context 'and x is moved left' do
            it {
              instance.send(:left)
              subject.must_equal(0)
            }

            it 'multiple times' do
              instance.send(:left)
              instance.send(:left)

              subject.must_equal(0)
            end
          end

          context 'and x is moved right' do
            it {
              instance.send(:right)
              subject.must_equal(1)
            }

            it 'multiple times' do
              instance.send(:right)
              instance.send(:right)

              subject.must_equal(2)
            end
          end
        end

        context 'when x > 0 && x <= size - 1' do
          let(:x) { 4 }

          it { subject.must_equal(4) }

          context 'and x is moved left' do
            it {
              instance.send(:left)
              subject.must_equal(3)
            }

            it 'multiple times' do
              instance.send(:left)
              instance.send(:left)

              subject.must_equal(2)
            end
          end

          context 'and x is moved right' do
            it {
              instance.send(:right)
              subject.must_equal(5)
            }

            it 'multiple times' do
              instance.send(:right)
              instance.send(:right)

              subject.must_equal(6)
            end
          end
        end

        context 'when x > size - 1' do
          let(:x) { 15 }

          it { subject.must_equal(11) }

          context 'and x is moved left' do
            it {
              instance.send(:left)
              subject.must_equal(10)
            }

            it 'multiple times' do
              instance.send(:left)
              instance.send(:left)

              subject.must_equal(9)
            end
          end

          context 'and x is moved right' do
            it {
              instance.send(:right)
              subject.must_equal(11)
            }

            it 'multiple times' do
              instance.send(:right)
              instance.send(:right)

              subject.must_equal(11)
            end
          end
        end
      end

  	end # Line

  end # Editor

end # Vedeu

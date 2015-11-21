require 'test_helper'

module Vedeu

  module Editor

    describe Lines do

      let(:described)  { Vedeu::Editor::Lines }
      let(:instance)   { described.new(collection) }
      let(:collection) {
        [
          Vedeu::Editor::Line.new('Some text...'),
          Vedeu::Editor::Line.new('More text...'),
          Vedeu::Editor::Line.new('Other text...')
        ]
      }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@collection').must_equal(collection) }

        context 'when lines were not given' do
          let(:collection) {}

          it { instance.instance_variable_get('@collection').must_equal([]) }
        end
      end

      describe 'accessors' do
        it { instance.must_respond_to(:collection) }
        it { instance.must_respond_to(:collection=) }
        it { instance.must_respond_to(:lines) }
      end

      describe '.coerce' do
        let(:document) {}

        subject { described.coerce(document) }

        it { subject.must_be_instance_of(described) }

        context 'when the document is already a Vedeu::Editor::Lines object' do
          let(:document) { Vedeu::Editor::Lines.new(collection) }

          it { subject.must_equal(document) }
          it { subject.collection.must_equal(collection) }
        end

        context 'when the document is an empty Array' do
          let(:document) { [] }

          it { subject.collection.must_equal([]) }
        end

        context 'when the document is an Array' do
          let(:document) {
            [
              Vedeu::Editor::Line.new('Some text...'),
              :more_text,
              'Other text...',
            ]
          }
          let(:expected) {
            [
              Vedeu::Editor::Line.new('Some text...'),
              Vedeu::Editor::Line.new(''),
              Vedeu::Editor::Line.new('Other text...'),
            ]
          }

          it { subject.collection.must_equal(expected) }
        end

        context 'when the document is a String' do
          let(:document) { "Some text...\nMore text..." }

          context 'but it is empty' do
            let(:document) { '' }

            it { subject.must_equal(Vedeu::Editor::Lines.new) }
          end

          context 'but it has no line breaks' do

          end
        end
      end

      describe '#delete_character' do
        let(:x)         { 0 }
        let(:y)         { 0 }

        subject { instance.delete_character(y, x) }

        context 'when there are no lines' do
          let(:collection) {
            [
              Vedeu::Editor::Line.new('')
            ]
          }
          let(:expected) {
            Vedeu::Editor::Lines.new([Vedeu::Editor::Line.new('')])
          }

          it { subject.must_equal(expected) }
        end

        context 'when there is one line' do
          let(:collection) {
            [
              Vedeu::Editor::Line.new('Hydrogen')
            ]
          }

          context 'and x is the first character of the line' do
            let(:x) { 0 }
            let(:expected) {
              Vedeu::Editor::Lines.new([Vedeu::Editor::Line.new('ydrogen')])
            }

            it { subject.must_equal(expected) }
          end

          context 'and x is somewhere on the line' do
            let(:x) { 4 }
            let(:expected) {
              Vedeu::Editor::Lines.new([Vedeu::Editor::Line.new('Hydrgen')])
            }

            it { subject.must_equal(expected) }
          end

          context 'and x is the last character of the line' do
            let(:x) { 15 }
            let(:expected) {
              Vedeu::Editor::Lines.new([Vedeu::Editor::Line.new('Hydroge')])
            }

            it { subject.must_equal(expected) }
          end
        end

        context 'when there are multiple lines' do
          let(:y)     { 1 }
          let(:collection) {
            [
              Vedeu::Editor::Line.new('Hydrogen'),
              Vedeu::Editor::Line.new('Helium'),
              Vedeu::Editor::Line.new('Lithium'),
            ]
          }

          context 'and x is the first character of the line' do
            let(:x) { 0 }
            let(:expected) {
              Vedeu::Editor::Lines.new([
                Vedeu::Editor::Line.new('Hydrogen'),
                Vedeu::Editor::Line.new('elium'),
                Vedeu::Editor::Line.new('Lithium'),
              ])
            }

            it { subject.must_equal(expected) }
          end

          context 'and x is somewhere on the line' do
            let(:x) { 4 }
            let(:expected) {
              Vedeu::Editor::Lines.new([
                Vedeu::Editor::Line.new('Hydrogen'),
                Vedeu::Editor::Line.new('Helim'),
                Vedeu::Editor::Line.new('Lithium'),
              ])
            }

            it { subject.must_equal(expected) }
          end

          context 'and x is the last character of the line' do
            let(:x) { 15 }
            let(:expected) {
              Vedeu::Editor::Lines.new([
                Vedeu::Editor::Line.new('Hydrogen'),
                Vedeu::Editor::Line.new('Heliu'),
                Vedeu::Editor::Line.new('Lithium'),
              ])
            }

            it { subject.must_equal(expected) }
          end
        end
      end

      describe '#delete_line' do
        let(:index) { 1 }

        subject { instance.delete_line(index) }

        it { subject.must_be_instance_of(described) }

        context 'when the lines are empty' do
          let(:collection) { [] }

          it { subject.must_equal(Vedeu::Editor::Lines.new) }
        end

        context 'when the lines are not empty' do
          context 'when an index is not given' do
            let(:index) {}
            let(:expected) {
              Vedeu::Editor::Lines.coerce(['Some text...', 'More text...'])
            }

            it { subject.must_equal(expected) }
          end

          context 'when a negative index is given' do
            let(:index) { -4 }
            let(:expected) {
              Vedeu::Editor::Lines.coerce(['Some text...', 'More text...', 'Other text...'])
            }

            it { subject.must_equal(expected) }
          end

          context 'when an index is given' do
            let(:expected) {
              Vedeu::Editor::Lines.coerce(['Some text...', 'Other text...'])
            }

            it { subject.must_equal(expected) }
          end

          context 'when an index of the last line is given' do
            let(:index) { 2 }
            let(:expected) {
              Vedeu::Editor::Lines.coerce(['Some text...', 'More text...'])
            }

            it { subject.must_equal(expected) }
          end

          context 'when an index greater than the number of lines is given' do
            let(:index) { 10 }
            let(:expected) {
              Vedeu::Editor::Lines.coerce(['Some text...', 'More text...'])
            }

            it { subject.must_equal(expected) }
          end
        end
      end

      describe '#insert_character' do
        let(:x)         { 0 }
        let(:y)         { 0 }
        let(:character) { 'a' }

        subject { instance.insert_character(character, y, x) }

        context 'when there are no lines' do
          let(:collection) {
            [
              Vedeu::Editor::Line.new('')
            ]
          }
          let(:expected) {
            Vedeu::Editor::Lines.new([Vedeu::Editor::Line.new('a')])
          }

          it { subject.must_equal(expected) }
        end

        context 'when there is one line' do
          let(:collection) {
            [
              Vedeu::Editor::Line.new('Hydrogen')
            ]
          }

          context 'and x is the first character of the line' do
            let(:x) { 0 }
            let(:expected) {
              Vedeu::Editor::Lines.new([Vedeu::Editor::Line.new('aHydrogen')])
            }

            it { subject.must_equal(expected) }
          end

          context 'and x is somewhere on the line' do
            let(:x) { 4 }
            let(:expected) {
              Vedeu::Editor::Lines.new([Vedeu::Editor::Line.new('Hydraogen')])
            }

            it { subject.must_equal(expected) }
          end

          context 'and x is the last character of the line' do
            let(:x) { 15 }
            let(:expected) {
              Vedeu::Editor::Lines.new([Vedeu::Editor::Line.new('Hydrogena')])
            }

            it { subject.must_equal(expected) }
          end
        end

        context 'when there are multiple lines' do
          let(:y)     { 1 }
          let(:collection) {
            [
              Vedeu::Editor::Line.new('Hydrogen'),
              Vedeu::Editor::Line.new('Helium'),
              Vedeu::Editor::Line.new('Lithium'),
            ]
          }

          context 'and x is the first character of the line' do
            let(:x) { 0 }
            let(:expected) {
              Vedeu::Editor::Lines.new([
                Vedeu::Editor::Line.new('Hydrogen'),
                Vedeu::Editor::Line.new('aHelium'),
                Vedeu::Editor::Line.new('Lithium'),
              ])
            }

            it { subject.must_equal(expected) }
          end

          context 'and x is somewhere on the line' do
            let(:x) { 4 }
            let(:expected) {
              Vedeu::Editor::Lines.new([
                Vedeu::Editor::Line.new('Hydrogen'),
                Vedeu::Editor::Line.new('Heliaum'),
                Vedeu::Editor::Line.new('Lithium'),
              ])
            }

            it { subject.must_equal(expected) }
          end

          context 'and x is the last character of the line' do
            let(:x) { 15 }
            let(:expected) {
              Vedeu::Editor::Lines.new([
                Vedeu::Editor::Line.new('Hydrogen'),
                Vedeu::Editor::Line.new('Heliuma'),
                Vedeu::Editor::Line.new('Lithium'),
              ])
            }

            it { subject.must_equal(expected) }
          end
        end
      end

      describe '#insert_line' do
        let(:index) { 1 }

        subject { instance.insert_line(index) }

        it { subject.must_be_instance_of(described) }

        context 'and an index is not given' do
          let(:index) {}
          let(:expected) {
            Vedeu::Editor::Lines.coerce(['Some text...', 'More text...', 'Other text...', ''])
          }

          it { subject.must_equal(expected) }
        end

        context 'and a negative index is given' do
          let(:index) { -4 }
          let(:expected) {
            Vedeu::Editor::Lines.coerce(['', 'Some text...', 'More text...', 'Other text...'])
          }

          it { subject.must_equal(expected) }
        end

        context 'and an index is given' do
          let(:expected) {
            Vedeu::Editor::Lines.coerce(['Some text...', '', 'More text...', 'Other text...'])
          }

          it { subject.must_equal(expected) }
        end

        context 'and an index of the last line is given' do
          let(:index) { 5 }
          let(:expected) {
            Vedeu::Editor::Lines.coerce(['Some text...', 'More text...', 'Other text...', ''])
          }

          it { subject.must_equal(expected) }
        end

        context 'and an index greater than the number of lines is given' do
          let(:index) { 10 }
          let(:expected) {
            Vedeu::Editor::Lines.coerce(['Some text...', 'More text...', 'Other text...', ''])
          }

          it { subject.must_equal(expected) }
        end
      end

      describe '#line' do
        let(:index) { 1 }

        subject { instance.line(index) }

        it { subject.must_be_instance_of(Vedeu::Editor::Line) }

        context 'when there are no lines' do
          let(:collection) {}

          it { subject.must_equal(Vedeu::Editor::Line.new) }
        end

        context 'when there are lines' do
          context 'and an index is not given' do
            let(:index) {}

            it 'returns the last line' do
              subject.must_equal(Vedeu::Editor::Line.new('Other text...'))
            end
          end

          context 'and an index is given' do
            context 'and a negative index is given' do
              let(:index) { -4 }

              it 'returns the first line' do
                subject.must_equal(Vedeu::Editor::Line.new('Some text...'))
              end
            end

            context 'and an index is given' do
              it { subject.must_equal(Vedeu::Editor::Line.new('More text...')) }
            end

            context 'and an index of the last line is given' do
              let(:index) { 5 }

              it { subject.must_equal(Vedeu::Editor::Line.new('Other text...')) }
            end

            context 'and an index greater than the number of lines is given' do
              let(:index) { 10 }

              it { subject.must_equal(Vedeu::Editor::Line.new('Other text...')) }
            end
          end
        end
      end

      describe '#to_s' do
        subject { instance.to_s }

        context 'when there are no lines' do
          let(:collection) {}

          it { subject.must_equal("") }
        end

        context 'when there are lines' do
          let(:expected) { "Some text...More text...Other text..." }

          it { subject.must_equal(expected) }
        end
      end

    end # Lines

  end # Editor

end # Vedeu

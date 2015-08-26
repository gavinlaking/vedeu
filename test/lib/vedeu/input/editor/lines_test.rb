require 'test_helper'

module Vedeu

  module Editor

    describe Lines do

      let(:described) { Vedeu::Editor::Lines }
      let(:instance)  { described.new(lines) }
      let(:lines)     { ['Some text...', 'More text...', 'Other text...'] }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@lines').must_equal(lines) }

        context 'when lines were not given' do
          let(:lines) {}

          it { instance.instance_variable_get('@lines').must_equal([]) }
        end
      end

      describe 'accessors' do
        it { instance.must_respond_to(:lines) }
        it { instance.must_respond_to(:lines=) }
      end

      describe '#delete_line' do
        let(:index) { 1 }

        subject { instance.delete_line(index) }

        it { subject.must_be_instance_of(Vedeu::Editor::Lines) }

        context 'when the lines are empty' do
          let(:lines) { [] }

          it { subject.lines.must_equal([]) }
        end

        context 'when the lines are not empty' do
          context 'when an index is not given' do
            let(:index) {}

            it { subject.lines.must_equal(['Some text...', 'More text...']) }
          end

          context 'when a negative index is given' do
            let(:index) { -4 }

            it { subject.lines.must_equal(['Some text...', 'More text...', 'Other text...']) }
          end

          context 'when an index is given' do
            it { subject.lines.must_equal(['Some text...', 'Other text...']) }
          end

          context 'when an index of the last line is given' do
            let(:index) { 2 }

            it { subject.lines.must_equal(['Some text...', 'More text...']) }
          end

          context 'when an index greater than the number of lines is given' do
            let(:index) { 10 }

            it { subject.lines.must_equal(['Some text...', 'More text...']) }
          end
        end
      end

      describe '#insert_line' do
        let(:line)  { "Many text..." }
        let(:index) { 1 }

        subject { instance.insert_line(line, index) }

        it { subject.must_be_instance_of(Vedeu::Editor::Lines) }

        context 'when a line is not given' do
          let(:line) {}

          it { subject.lines.must_equal(['Some text...', 'More text...', 'Other text...']) }
        end

        context 'when a line is given' do
          context 'and an index is not given' do
            let(:index) {}

            it { subject.lines.must_equal(['Some text...', 'More text...', 'Other text...', 'Many text...']) }
          end

          context 'and a negative index is given' do
            let(:index) { -4 }

            it { subject.lines.must_equal(['Many text...', 'Some text...', 'More text...', 'Other text...']) }
          end

          context 'and an index is given' do
            it { subject.lines.must_equal(['Some text...', 'Many text...', 'More text...', 'Other text...']) }
          end

          context 'and an index of the last line is given' do
            let(:index) { 5 }

            it { subject.lines.must_equal(['Some text...', 'More text...', 'Other text...', 'Many text...']) }
          end

          context 'and an index greater than the number of lines is given' do
            let(:index) { 10 }

            it { subject.lines.must_equal(['Some text...', 'More text...', 'Other text...', 'Many text...']) }
          end
        end
      end

      describe '#line' do
        let(:index) { 1 }

        subject { instance.line(index) }

        it { subject.must_be_instance_of(Vedeu::Editor::Line) }

        context 'when there are no lines' do
          let(:lines) {}

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

    end # Lines

  end # Editor

end # Vedeu

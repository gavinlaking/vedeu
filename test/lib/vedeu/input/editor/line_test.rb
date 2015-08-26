require 'test_helper'

module Vedeu

  module Editor

    describe Line do

      let(:described) { Vedeu::Editor::Line }
      let(:instance)  { described.new(line) }
      let(:line)      { 'Some text...' }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@line').must_equal(line) }

        context 'when a line is not given' do
          let(:line) {}

          it { instance.instance_variable_get('@line').must_equal('') }
        end
      end

      describe 'accessors' do
        it { instance.must_respond_to(:line) }
        it { instance.must_respond_to(:line=) }
      end

      describe '#delete_character' do
        let(:index) { 5 }

        subject { instance.delete_character(index) }

        it { subject.must_be_instance_of(Vedeu::Editor::Line) }

        context 'when the line is empty' do
          let(:line) { '' }

          it { subject.line.must_equal('') }

          context 'and an index is not given' do
            let(:index) {}

            it { subject.line.must_equal('') }
          end
        end

        context 'when the line is not empty' do
          context 'when an index is not given' do
            let(:index) {}

            it { subject.line.must_equal('Some text..') }
          end

          context 'when a negative index is given' do
            let(:index) { -4 }

            it { subject.line.must_equal('Some text...') }
          end

          context 'when an index is given' do
            it { subject.line.must_equal('Some ext...') }
          end

          context 'when an index of the last character of the line is given' do
            let(:index) { 12 }

            it { subject.line.must_equal('Some text..') }
          end

          context 'when an index greater than the line length is given' do
            let(:index) { 20 }

            it { subject.line.must_equal('Some text..') }
          end
        end
      end

      describe '#eql?' do
        let(:other) { instance }

        subject { instance.eql?(other) }

        it { subject.must_equal(true) }

        context 'when different to other' do
          let(:other) { described.new('Other text...') }

          it { subject.must_equal(false) }
        end
      end

      describe '#insert_character' do
        let(:character) { 'a' }
        let(:index)     { 5 }

        subject { instance.insert_character(character, index) }

        it { subject.must_be_instance_of(Vedeu::Editor::Line) }

        context 'when the line is empty' do
          let(:line) {}

          it { subject.line.must_equal('a') }

          context 'and an index is not given' do
            let(:index) {}

            it { subject.line.must_equal('a') }
          end

          context 'and a negative index is given' do
            let(:index) { -4 }

            it { subject.line.must_equal('a') }
          end

          context 'and an index is given' do
            it { subject.line.must_equal('a') }
          end

          context 'and an index of the last character of the line is given' do
            let(:index) { 0 }

            it { subject.line.must_equal('a') }
          end

          context 'and an index greater than the line length is given' do
            let(:index) { 20 }

            it { subject.line.must_equal('a') }
          end
        end

        context 'when the line is not empty' do
          context 'and an index is not given' do
            let(:index) {}

            it { subject.line.must_equal('Some text...a') }
          end

          context 'and a negative index is given' do
            let(:index) { -4 }

            it { subject.line.must_equal('aSome text...') }
          end

          context 'and an index is given' do
            it { subject.line.must_equal('Some atext...') }
          end

          context 'and an index of the last character of the line is given' do
            let(:index) { 12 }

            it { subject.line.must_equal('Some text...a') }
          end

          context 'and an index greater than the line length is given' do
            let(:index) { 20 }

            it { subject.line.must_equal('Some text...a') }
          end
        end
      end

    end # Line

  end # Editor

end # Vedeu

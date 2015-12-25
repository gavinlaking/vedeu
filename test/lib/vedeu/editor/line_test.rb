# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Editor

    describe Line do

      let(:described)  { Vedeu::Editor::Line }
      let(:instance)   { described.new(collection) }
      let(:collection) { 'Some text...' }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@collection').must_equal(collection) }

        context 'when a line is not given' do
          let(:collection) {}

          it { instance.instance_variable_get('@collection').must_equal('') }
        end
      end

      describe '#collection' do
        it { instance.must_respond_to(:collection) }
      end

      describe '#collection=' do
        it { instance.must_respond_to(:collection=) }
      end

      describe '.coerce' do
        let(:_value) {}

        subject { described.coerce(_value) }

        it { subject.must_be_instance_of(Vedeu::Editor::Line) }

        context 'when the value is already a Vedeu::Editor::Line object' do
          let(:_value) { Vedeu::Editor::Line.new(collection) }

          it { subject.must_equal(_value) }
          it { subject.collection.must_equal(collection) }
        end

        context 'when the value is an empty String' do
          let(:_value) { '' }

          it { subject.collection.must_equal('') }
        end

        context 'when the value is an String' do
          let(:_value) { collection }

          it { subject.collection.must_equal(collection) }
        end
      end

      describe '#character' do
        let(:index) { 5 }

        subject { instance.character(index) }

        it { subject.must_be_instance_of(String) }

        context 'when the line is empty' do
          let(:collection) { '' }

          context 'and an index is not given' do
            let(:index) {}

            it { subject.must_equal('') }
          end
        end

        context 'when the line is not empty' do
          context 'when an index is not given' do
            let(:index) {}

            it { subject.must_equal('.') }
          end

          context 'when a negative index is given' do
            let(:index) { -4 }

            it { subject.must_equal('S') }
          end

          context 'when an index is given' do
            it { subject.must_equal('t') }
          end

          context 'when an index of the last character of the line is given' do
            let(:index) { 11 }

            it { subject.must_equal('.') }
          end

          context 'when an index greater than the line length is given' do
            let(:index) { 20 }

            it { subject.must_equal('.') }
          end
        end
      end

      describe '#delete_character' do
        let(:index) { 5 }

        subject { instance.delete_character(index) }

        it { subject.must_be_instance_of(Vedeu::Editor::Line) }

        context 'when the line is empty' do
          let(:collection) { '' }

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
            let(:index) { 11 }

            it { subject.line.must_equal('Some text..') }
          end

          context 'when an index greater than the line length is given' do
            let(:index) { 20 }

            it { subject.line.must_equal('Some text..') }
          end
        end
      end

      describe '#insert_character' do
        let(:character) { 'a' }
        let(:index)     { 5 }

        subject { instance.insert_character(character, index) }

        it { subject.must_be_instance_of(Vedeu::Editor::Line) }

        context 'when the line is empty' do
          let(:collection) {}

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

      describe '#to_s' do
        subject { instance.to_s }

        context 'when the line is empty' do
          let(:collection) {}

          it { subject.must_equal('') }
        end

        context 'when the line is not empty' do
          it { subject.must_equal('Some text...') }
        end
      end

    end # Line

  end # Editor

end # Vedeu

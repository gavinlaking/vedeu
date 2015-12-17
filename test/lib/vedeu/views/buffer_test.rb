require 'test_helper'

module Vedeu

  module Views

    describe Buffer do

      let(:described)     { Vedeu::Views::Buffer }
      let(:instance)      { described.new(view) }
      let(:view)          { Vedeu::Views::View.new(value: lines) }
      let(:lines)         { [line_1, line_2, line_3] }
      let(:line_1)        { Vedeu::Views::Line.new(value: streams_1) }
      let(:line_2)        { Vedeu::Views::Line.new(value: streams_2) }
      let(:line_3)        { Vedeu::Views::Line.new(value: streams_3) }
      let(:streams_1)     { [stream_1, stream_2] }
      let(:streams_2)     { [] }
      let(:streams_3)     { [stream_3] }
      let(:stream_1)      { Vedeu::Views::Stream.new(value: value_1) }
      let(:stream_2)      { Vedeu::Views::Stream.new(value: value_2) }
      let(:stream_3)      { Vedeu::Views::Stream.new(value: value_3) }
      let(:value_1)       { 'Some... ' }
      let(:value_2)       { '' }
      let(:value_3)       { 'text... ' }
      let(:chars_1)       {
        value_1.chars.map { |char| Vedeu::Views::Char.new(value: char) }
      }
      let(:chars_2) {
        value_2.chars.map { |char| Vedeu::Views::Char.new(value: char) }
      }
      let(:chars_3) {
        value_3.chars.map { |char| Vedeu::Views::Char.new(value: char) }
      }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@view').must_equal(view) }
      end

      describe '#transform' do
        subject { instance.transform }

        context 'when the view has multiple lines' do
          let(:lines)    { [line_1, line_2, line_3] }
          let(:expected) {
            [
              [chars_1, chars_2],
              [],
              [chars_3],
            ]
          }

          it { subject.must_equal(expected) }
          it { subject.all? { |element| element.is_a?(Vedeu::Views::Char) } }
        end

        context 'when the view has a line' do
          let(:lines) { [line_1] }

          context 'when the line has multiple streams' do
            let(:expected) { [[chars_1, chars_2]] }

            it { subject.must_equal(expected) }
          end

          context 'when the line has a stream' do
            let(:streams) { [stream_1] }

            context 'when the stream has a value' do
              let(:expected) { [[chars_1, chars_2]] }

              it { subject.must_equal(expected) }
            end

            context 'when the stream has no value' do
              let(:value_1) {}

              it { subject.must_equal([[[], []]]) }
            end
          end

          context 'when the line has no streams' do
            let(:lines) { [line_2] }

            it { subject.must_equal([[]]) }
          end
        end

        context 'when the view has no lines' do
          let(:lines) { [] }

          it { subject.must_equal([]) }
        end
      end

    end # Buffer

  end # Views

end # Vedeu

require 'test_helper'

module Vedeu

  describe Presentation do

    let(:receiver) { PresentationTestClass.new }

    describe '#to_s' do
      let(:line) { Line.new(
          [],
          mock('Interface'),
          Colour.new({ foreground: '#00ff00', background: '#000000' }),
          Style.new('normal')
        )
      }
      let(:stream) { Stream.new(stream_value, line, stream_colour, stream_style) }
      let(:stream_value)  { 'Some text' }
      let(:stream_colour) { Colour.new({ foreground: '#ff0000', background: '#000000' }) }
      let(:stream_style)  { Style.new(:underline) }

      it 'returns output' do
        stream.to_s.must_equal(
          # - stream colour
          # - stream style
          # - stream content
          # - line style
          # - line colour
          "\e[38;2;255;0;0m\e[48;2;0;0;0m"  \
          "\e[4m"                           \
          "Some text"                       \
          "\e[24m\e[22m\e[27m"              \
          "\e[38;2;0;255;0m\e[48;2;0;0;0m"
        )
      end
    end

  end # Presentation

end # Vedeu

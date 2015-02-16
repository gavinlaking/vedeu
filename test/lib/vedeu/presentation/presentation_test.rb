require 'test_helper'

module Vedeu

  describe Presentation do

    let(:receiver) { PresentationTestClass.new }

    describe '#colour=' do
      let(:colour) { Colour.new({ foreground: '#00ff00', background: '#000000' }) }

      subject { receiver.colour=(colour) }

      it { subject.must_be_instance_of(Colour) }
    end

    describe '#style=' do
      let(:style) { Style.new('normal') }

      subject { receiver.style=(style) }

      it { subject.must_be_instance_of(Style) }
    end

    describe '#to_s' do
      let(:line) {
        Vedeu::Line.new({
          streams: [],
          parent:  mock('Interface'),
          colour:  Colour.new({ foreground: '#00ff00', background: '#000000' }),
          style:   Style.new('normal')
        })
      }
      let(:stream) { Stream.new({ value: stream_value, parent: line, colour: stream_colour, style: stream_style }) }
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

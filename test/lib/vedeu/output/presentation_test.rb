require 'test_helper'

module Vedeu

  class ParentPresentationTestClass
    include Presentation

    def parent
      nil
    end

    def attributes
      {
        colour: { background: '#330000', foreground: '#00aadd' },
        style:  ['bold']
      }
    end
  end

  class PresentationTestClass
    include Presentation

    def parent
      ParentPresentationTestClass.new
    end

    def attributes
      {
        colour: { background: '#000033', foreground: '#aadd00' },
        style:  ['bold']
      }
    end
  end # PresentationTestClass

  describe Presentation do

    let(:receiver) { PresentationTestClass.new }

    describe '#background' do
      subject { receiver.background }

      it { subject.must_be_instance_of(Vedeu::Background) }
    end

    describe '#foreground' do
      subject { receiver.foreground }

      it { subject.must_be_instance_of(Vedeu::Foreground) }
    end

    describe '#parent_background' do
      subject { receiver.parent_background }
    end

    describe '#parent_foreground' do
      subject { receiver.parent_foreground }
    end

    describe '#colour' do
      subject { receiver.colour }

      it { subject.must_be_instance_of(Vedeu::Colour) }
    end

    describe '#colour=' do
      let(:colour) { Colour.new(foreground: '#00ff00', background: '#000000') }

      subject { receiver.colour = (colour) }

      it { subject.must_be_instance_of(Colour) }
    end

    describe '#style' do
      subject { receiver.style }

      it { subject.must_be_instance_of(Vedeu::Style) }
    end

    describe '#style=' do
      let(:style) { Style.new('normal') }

      subject { receiver.style = (style) }

      it { subject.must_be_instance_of(Style) }
    end

    describe '#to_s' do
      let(:line) {
        Vedeu::Line.new(streams: [],
                        parent:  Vedeu::Interface.new,
                        colour:  line_colour,
                        style:   Style.new('normal'))
      }
      let(:line_colour) {
        Colour.new(foreground: '#00ff00', background: '#000000')
      }
      let(:stream) {
        Stream.new(value: stream_value,
                   parent: line,
                   colour: stream_colour,
                   style: stream_style)
      }
      let(:stream_value)  { 'Some text' }
      let(:stream_colour) {
        Colour.new(foreground: '#ff0000', background: '#000000')
      }
      let(:stream_style)  { Style.new(:underline) }

      it 'returns output' do
        stream.to_s.must_equal(
          # - stream colour
          # - stream style
          # - stream content
          "\e[38;2;255;0;0m\e[48;2;0;0;0m"  \
          "\e[4m"                           \
          'Some text'
        )
      end
    end

  end # Presentation

end # Vedeu

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

    attr_reader :attributes

    def initialize(attributes = {})
      @attributes = attributes
    end

    def parent
      ParentPresentationTestClass.new
    end

  end # PresentationTestClass

  describe Presentation do

    let(:receiver) { PresentationTestClass.new(attributes) }
    let(:attributes) {
      {
        colour: { background: background, foreground: foreground },
        style:  ['bold']
      }
    }
    let(:background) { '#000033' }
    let(:foreground) { '#aadd00' }

    describe '#background' do
      subject { receiver.background }

      it { subject.must_be_instance_of(Vedeu::Background) }
      it { subject.colour.must_equal('#000033') }

      context 'no background value' do
        let(:attributes) { {} }
        let(:background) {}

        it { subject.must_be_instance_of(Vedeu::Background) }
        # it { subject.colour.must_equal('') }
      end
    end

    describe '#background=' do
      subject { receiver.background = '#987654' }

      it { subject.must_equal('#987654') }

      it do
        subject
        receiver.attributes[:background].must_equal('#987654')
      end
    end

    describe '#foreground' do
      subject { receiver.foreground }

      it { subject.must_be_instance_of(Vedeu::Foreground) }
      it { subject.colour.must_equal('#aadd00') }

      context 'no foreground value' do
        let(:attributes) { {} }
        let(:foreground) {}

        it { subject.must_be_instance_of(Vedeu::Foreground) }
        # it { subject.colour.must_equal('') }
      end
    end

    describe '#foreground=' do
      subject { receiver.foreground = '#123456' }

      it { subject.must_equal('#123456') }

      it do
        subject
        receiver.attributes[:foreground].must_equal('#123456')
      end
    end

    describe '#parent_background' do
      subject { receiver.parent_background }

      it { subject.must_be_instance_of(Vedeu::Background) }
    end

    describe '#parent_foreground' do
      subject { receiver.parent_foreground }

      it { subject.must_be_instance_of(Vedeu::Foreground) }
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

      it { receiver.must_respond_to(:to_str) }

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

require 'test_helper'

module Vedeu

  class ParentPresentationTestClass
    include Vedeu::Presentation

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
    include Vedeu::Presentation

    attr_reader :attributes

    def initialize(attributes = {})
      @attributes = attributes
    end

    def parent
      Vedeu::ParentPresentationTestClass.new
    end

  end # PresentationTestClass

  describe Presentation do

    let(:includer) { Vedeu::PresentationTestClass.new(attributes) }
    let(:attributes) {
      {
        colour: { background: background, foreground: foreground },
        style:  ['bold']
      }
    }
    let(:background) { '#000033' }
    let(:foreground) { '#aadd00' }

    describe '#background' do
      subject { includer.background }

      it { subject.must_be_instance_of(Vedeu::Background) }
      it { subject.colour.must_equal('#000033') }

      context 'no background value' do
        let(:attributes) { {} }
        let(:background) {}

        it { subject.must_be_instance_of(Vedeu::Background) }
        it { subject.colour.must_equal('#330000') }
      end
    end

    describe '#background=' do
      subject { includer.background = '#987654' }

      it {
        includer.colour.background.colour.must_equal('#000033')
        subject
        includer.colour.background.colour.must_equal('#987654')
      }

      it { subject.must_equal('#987654') }
    end

    describe '#foreground' do
      subject { includer.foreground }

      it { subject.must_be_instance_of(Vedeu::Foreground) }
      it { subject.colour.must_equal('#aadd00') }

      context 'no foreground value' do
        let(:attributes) { {} }
        let(:foreground) {}

        it { subject.must_be_instance_of(Vedeu::Foreground) }
        it { subject.colour.must_equal('#00aadd') }
      end
    end

    describe '#foreground=' do
      subject { includer.foreground = '#123456' }

      it {
        includer.colour.foreground.colour.must_equal('#aadd00')
        subject
        includer.colour.foreground.colour.must_equal('#123456')
      }

      it { subject.must_equal('#123456') }
    end

    describe '#parent_background' do
      subject { includer.parent_background }

      it { subject.must_be_instance_of(Vedeu::Background) }
      it { subject.colour.must_equal('#330000') }

      context 'when no parent colour is set' do
        before { includer.stubs(:parent).returns(nil) }

        it { subject.colour.must_equal('') }
      end
    end

    describe '#parent_colour' do
      subject { includer.parent_colour }

      context 'when a parent is available' do
        it { subject.must_be_instance_of(Vedeu::Colour) }
        it { subject.background.must_be_instance_of(Vedeu::Background) }
        it { subject.foreground.must_be_instance_of(Vedeu::Foreground) }
      end

      context 'when a parent is not available' do
        before { includer.stubs(:parent).returns(nil) }

        it { subject.must_equal(nil) }
      end
    end

    describe '#parent_foreground' do
      subject { includer.parent_foreground }

      it { subject.must_be_instance_of(Vedeu::Foreground) }
      it { subject.colour.must_equal('#00aadd') }

      context 'when no parent colour is set' do
        before { includer.stubs(:parent).returns(nil) }

        it { subject.colour.must_equal('') }
      end
    end

    describe '#colour' do
      subject { includer.colour }

      it { subject.must_be_instance_of(Vedeu::Colour) }
    end

    describe '#colour=' do
      let(:colour) { Colour.new(foreground: '#00ff00', background: '#000000') }

      subject { includer.colour = (colour) }

      it { subject.must_be_instance_of(Colour) }
    end

    describe '#parent_style' do
      subject { includer.parent_style }

      it { subject.must_be_instance_of(Vedeu::Style) }

      context 'when a parent is available' do
        it { subject.value.must_equal(['bold']) }
      end

      context 'when a parent is not available' do
        before { includer.stubs(:parent).returns(nil) }

        it { subject.value.must_equal(nil) }
      end
    end

    describe '#style' do
      subject { includer.style }

      it { subject.must_be_instance_of(Vedeu::Style) }
    end

    describe '#style=' do
      let(:style) { Style.new('normal') }

      subject { includer.style = (style) }

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

      it { includer.must_respond_to(:to_str) }

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

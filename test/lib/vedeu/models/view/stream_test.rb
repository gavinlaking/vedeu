require 'test_helper'

module Vedeu

  describe Stream do

    let(:described)  { Vedeu::Stream }
    let(:instance)   { described.new(attributes) }
    let(:attributes) {
      {
        value:  value,
        parent: parent,
        colour: colour,
        style:  style
      }
    }
    let(:value)      { 'Some text' }
    let(:parent)     {
      Line.new({
        streams: [],
        parent:  line_parent,
        colour:  Colour.new({ background: '#0000ff', foreground: '#ffff00' }),
        style:   Style.new('normal')
      })
    }
    let(:colour)      { Colour.new({ background: '#ff0000', foreground: '#000000' }) }
    let(:style)       { Style.new('normal') }
    let(:line_parent) { Vedeu::Interface.new }

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
      it { instance.instance_variable_get('@value').must_equal(value) }
      it { instance.instance_variable_get('@parent').must_equal(parent) }
      it { instance.instance_variable_get('@colour').must_equal(colour) }
      it { instance.instance_variable_get('@style').must_equal(style) }
    end

    describe '#add' do
      let(:child) { instance }

      subject { instance.add(child) }

      it { subject.must_be_instance_of(Vedeu::Streams) }
    end

    describe '#chars' do
      subject { instance.chars }

      it { subject.must_be_instance_of(Array) }

      context 'when there is content' do
        it 'returns a collection of strings containing escape sequences and ' \
           'content' do
          subject.must_equal(
            [
              "\e[38;2;0;0;0m\e[48;2;255;0;0m\e[24m\e[22m\e[27mS\e[24m\e[22m\e[27m\e[38;2;255;255;0m\e[48;2;0;0;255m",
              "\e[38;2;0;0;0m\e[48;2;255;0;0m\e[24m\e[22m\e[27mo\e[24m\e[22m\e[27m\e[38;2;255;255;0m\e[48;2;0;0;255m",
              "\e[38;2;0;0;0m\e[48;2;255;0;0m\e[24m\e[22m\e[27mm\e[24m\e[22m\e[27m\e[38;2;255;255;0m\e[48;2;0;0;255m",
              "\e[38;2;0;0;0m\e[48;2;255;0;0m\e[24m\e[22m\e[27me\e[24m\e[22m\e[27m\e[38;2;255;255;0m\e[48;2;0;0;255m",
              "\e[38;2;0;0;0m\e[48;2;255;0;0m\e[24m\e[22m\e[27m \e[24m\e[22m\e[27m\e[38;2;255;255;0m\e[48;2;0;0;255m",
              "\e[38;2;0;0;0m\e[48;2;255;0;0m\e[24m\e[22m\e[27mt\e[24m\e[22m\e[27m\e[38;2;255;255;0m\e[48;2;0;0;255m",
              "\e[38;2;0;0;0m\e[48;2;255;0;0m\e[24m\e[22m\e[27me\e[24m\e[22m\e[27m\e[38;2;255;255;0m\e[48;2;0;0;255m",
              "\e[38;2;0;0;0m\e[48;2;255;0;0m\e[24m\e[22m\e[27mx\e[24m\e[22m\e[27m\e[38;2;255;255;0m\e[48;2;0;0;255m",
              "\e[38;2;0;0;0m\e[48;2;255;0;0m\e[24m\e[22m\e[27mt\e[24m\e[22m\e[27m\e[38;2;255;255;0m\e[48;2;0;0;255m"
            ]
          )
        end
      end

      context 'when there is no content' do
        let(:value) { '' }

        it 'returns an empty collection' do
          subject.must_equal([])
        end
      end
    end

    describe '#empty?' do
      subject { instance.empty? }

      context 'when there is no content' do
        let(:value) { '' }

        it { subject.must_equal(true) }
      end

      context 'when there is content' do
        it { subject.must_equal(false) }
      end
    end

    describe '#size' do
      subject { instance.size }

      it { subject.must_be_instance_of(Fixnum) }

      it 'returns the size of the stream' do
        subject.must_equal(9)
      end
    end

    describe '#width' do
      before { line_parent.stubs(:width).returns(25) }

      subject { instance.width }

      it { subject.must_be_instance_of(Fixnum) }
      it { subject.must_equal(25) }
    end

  end # Stream

end # Vedeu

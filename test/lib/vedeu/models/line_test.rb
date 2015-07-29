require 'test_helper'

module Vedeu

  describe Line do

    let(:described)  { Vedeu::Line }
    let(:instance)   { described.new(attributes) }
    let(:attributes) {
      {
        streams: streams,
        parent:  parent,
        colour:  colour,
        style:   style,
      }
    }
    let(:streams)   {
      [
        Stream.new(value: 'Something interesting ',
                   parent: streams_parent,
                   colour: Colour.new(foreground: '#ffff00'),
                   style:  Style.new('normal')),
        Stream.new(value: 'on this line ',
                   parent: streams_parent,
                   colour: Colour.new(foreground: '#00ff00'),
                   style:  Style.new('normal')),
        Stream.new(value: 'would be cool, eh?',
                   parent: streams_parent,
                   colour: Colour.new(foreground: '#0000ff'),
                   style:  Style.new('normal'))
      ]
    }

    let(:streams_parent) {
      Line.new(streams: nil, parent: parent, colour: colour, style: style)
    }

    let(:parent)    { Vedeu::Interface.new(name: 'Vedeu::Line') }
    let(:colour)    { Colour.new(foreground: '#ff0000', background: '#000000') }
    let(:style)     { Style.new('normal') }

    # before do
    #   parent.stubs(:colour)
    #   parent.stubs(:style)
    # end

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
      it { instance.instance_variable_get('@streams').must_equal(streams) }
      it { instance.instance_variable_get('@parent').must_equal(parent) }
    end

    describe 'accessors' do
      it { instance.must_respond_to(:parent) }
      it { instance.must_respond_to(:parent=) }
      it { instance.must_respond_to(:attributes) }
    end

    describe '#add' do
      subject { instance.add(child) }

      it { instance.must_respond_to(:add) }

      it { instance.must_respond_to(:<<) }
    end

    describe '#chars' do
      subject { instance.chars }

      it { subject.must_be_instance_of(Array) }

      context 'when there is no content' do
        let(:streams) { [] }

        it { subject.must_equal([]) }
      end

      context 'when there is content' do
        it { subject.size.must_equal(53) }
      end
    end

    describe '#empty?' do
      subject { instance.empty? }

      context 'when there is no content' do
        let(:streams) { [] }

        it { subject.must_be_instance_of(TrueClass) }
      end

      context 'when there is content' do
        it { subject.must_be_instance_of(FalseClass) }
      end
    end

    describe '#eql?' do
      let(:other) { instance }

      subject { instance.eql?(other) }

      it { subject.must_equal(true) }

      context 'when different to other' do
        let(:other) { described.new(streams: [:other]) }

        it { subject.must_equal(false) }
      end
    end

    describe '#name' do
      subject { instance.name }

      context 'when a parent is defined' do
        it { subject.must_be_instance_of(String) }
      end

      context 'when a parent is not defined' do
        before { instance.stubs(:parent) }

        it { subject.must_be_instance_of(NilClass) }
      end
    end

    describe '#size' do
      subject { instance.size }

      it { subject.must_be_instance_of(Fixnum) }

      it 'returns the size of the line' do
        subject.must_equal(53)
      end
    end

    describe '#streams' do
      subject { instance.streams }

      it { instance.must_respond_to(:value) }

      it { subject.must_be_instance_of(Vedeu::Streams) }
    end

    describe '#to_s' do
      subject { instance.to_s }

      it { subject.must_be_instance_of(String) }

      it 'returns the line complete with formatting' do
        # (starts in Line colour)
        # (starts in Line style)
        # Stream 1 colour
        # Stream 1 style
        # Stream 1 value
        # (resets style to Line style)
        # (resets colour to Line colour)
        # Stream 2 colour
        # Stream 2 style
        # Stream 2 value
        # (resets style to Line style)
        # (resets colour to Line colour)
        # Stream 3 colour
        # Stream 3 style
        # Stream 3 value
        # (resets style to Line style)
        # (resets colour to Line colour)

        subject.must_equal(
          "\e[38;2;255;0;0m\e[48;2;0;0;0m"  \
          "\e[24m\e[22m\e[27m"              \
          "\e[38;2;255;255;0m"              \
          "\e[24m\e[22m\e[27m"              \
          'Something interesting '          \
          "\e[38;2;0;255;0m"                \
          "\e[24m\e[22m\e[27m"              \
          'on this line '                   \
          "\e[38;2;0;0;255m"                \
          "\e[24m\e[22m\e[27m"              \
          'would be cool, eh?'
        )
      end
    end

    describe '#width' do
      before { parent.stubs(:width).returns(25) }

      subject { instance.width }

      it { subject.must_be_instance_of(Fixnum) }
      it { subject.must_equal(25) }
    end

  end # Line

end # Vedeu

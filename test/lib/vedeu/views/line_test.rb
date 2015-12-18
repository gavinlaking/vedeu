require 'test_helper'

module Vedeu

  module Views

    describe Lines do

      let(:described) { Vedeu::Views::Lines }
      let(:instance)  { described.new }

      it { described.superclass.must_equal(Vedeu::Repositories::Collection) }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
      end

    end # Lines

    describe Line do

      let(:described)  { Vedeu::Views::Line }
      let(:instance)   { described.new(attributes) }
      let(:attributes) {
        {
          value:  _value,
          parent: parent,
          colour: colour,
          style:  style,
        }
      }
      let(:_value)   {
        [
          Vedeu::Views::Stream.new(value: 'Something interesting ',
                                   parent: streams_parent,
                                   colour: yellow,
                                   style:  normal_style),
          Vedeu::Views::Stream.new(value: 'on this line ',
                                   parent: streams_parent,
                                   colour: green,
                                   style:  normal_style),
          Vedeu::Views::Stream.new(value: 'would be cool, eh?',
                                   parent: streams_parent,
                                   colour: blue,
                                   style:  normal_style)
        ]
      }
      let(:yellow)       { Vedeu::Colours::Colour.new(foreground: '#ffff00') }
      let(:green)        { Vedeu::Colours::Colour.new(foreground: '#00ff00') }
      let(:blue)         { Vedeu::Colours::Colour.new(foreground: '#0000ff') }
      let(:normal_style) { Vedeu::Presentation::Style.new('normal') }

      let(:streams_parent) {
        Vedeu::Views::Line.new(value:  nil,
                               parent: parent,
                               colour: colour,
                               style:  style)
      }

      let(:parent) { Vedeu::Views::View.new(name: 'Vedeu::Line') }
      let(:style)  { Vedeu::Presentation::Style.new('normal') }
      let(:colour) {
        Vedeu::Colours::Colour.new(foreground: '#ff0000', background: '#000000')
      }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@value').must_equal(_value) }
        it { instance.instance_variable_get('@parent').must_equal(parent) }
      end

      describe 'accessors' do
        it do
          instance.must_respond_to(:client)
          instance.must_respond_to(:client=)
          instance.must_respond_to(:parent)
          instance.must_respond_to(:parent=)
        end
      end

      describe '#add' do
        subject { instance.add(child) }

        it { instance.must_respond_to(:add) }
        it { instance.must_respond_to(:<<) }
      end

      describe '#attributes' do
        subject { instance.attributes }

        it { subject.must_be_instance_of(Hash) }
      end

      describe '#chars' do
        subject { instance.chars }

        it { subject.must_be_instance_of(Array) }

        context 'when there is no content' do
          let(:_value) { [] }

          it { subject.must_equal([]) }
        end

        context 'when there is content' do
          it { subject.size.must_equal(53) }
        end
      end

      describe '#deputy' do
        subject { instance.deputy }

        it 'returns the DSL instance' do
          subject.must_be_instance_of(Vedeu::DSL::Line)
        end
      end

      describe '#eql?' do
        let(:other) { instance }

        subject { instance.eql?(other) }

        it { instance.must_respond_to(:==) }

        it { subject.must_equal(true) }

        context 'when different to other' do
          let(:other) { described.new(value: [:other]) }

          it { subject.must_equal(false) }
        end
      end

      describe '#name' do
        subject { instance.name }

        context 'when a parent is set' do
          it { subject.must_equal('Vedeu::Line') }
        end

        context 'when a parent is not set' do
          let(:parent) {}

          it { subject.must_equal(nil) }
        end
      end

      describe '#size' do
        subject { instance.size }

        it { subject.must_be_instance_of(Fixnum) }

        it 'returns the size of the line' do
          subject.must_equal(53)
        end
      end

      describe '#value' do
        subject { instance.value }

        it { instance.must_respond_to(:streams) }

        it { subject.must_be_instance_of(Vedeu::Views::Streams) }
      end

      describe '#value?' do
        subject { instance.value? }

        it { instance.must_respond_to(:streams?) }

        context 'when the line has no streams' do
          let(:_value) {}

          it { subject.must_equal(false) }
        end

        context 'when the line has streams' do
          before { instance.add(Vedeu::Views::Stream.new) }

          it { subject.must_equal(true) }
        end
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

    end # Line

  end # Views

end # Vedeu

require 'test_helper'

module Vedeu

  module Views

    describe Stream do

      let(:described)  { Vedeu::Views::Stream }
      let(:instance)   { described.new(attributes) }
      let(:attributes) {
        {
          value:  _value,
          parent: parent,
          colour: colour,
          style:  style
        }
      }
      let(:_value)  { 'Some text' }
      let(:parent) {
        Vedeu::Views::Line.new(value:  [],
                               parent: line_parent,
                               colour: parent_colour,
                               style:  style)
      }
      let(:parent_colour) {
        Vedeu::Colours::Colour.new(background: '#0000ff', foreground: '#ffff00')
      }
      let(:colour)      {
        Vedeu::Colours::Colour.new(background: '#ff0000', foreground: '#000000')
      }
      let(:style)       { Vedeu::Style.new('normal') }
      let(:line_parent) { Vedeu::Views::View.new(name: 'Vedeu::Views::Stream') }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@value').must_equal(_value) }
        it { instance.instance_variable_get('@parent').must_equal(parent) }
      end

      describe 'accessors' do
        it { instance.must_respond_to(:parent) }
        it { instance.must_respond_to(:parent=) }
        it { instance.must_respond_to(:value) }
        it { instance.must_respond_to(:content) }
        it { instance.must_respond_to(:text) }
        it { instance.must_respond_to(:value=) }
        it { instance.must_respond_to(:attributes) }
      end

      describe '#add' do
        let(:child) { instance }

        subject { instance.add(child) }

        it { subject.must_be_instance_of(Vedeu::Views::Streams) }

        it { instance.must_respond_to(:<<) }
      end

      describe '#chars' do
        subject { instance.chars }

        it { subject.must_be_instance_of(Array) }

        context 'when there is content' do
          it { subject.size.must_equal(9) }
        end

        context 'when there is no content' do
          let(:_value) { '' }

          it 'returns an empty collection' do
            subject.must_equal([])
          end
        end
      end

      describe '#eql?' do
        let(:other) { described.new(attributes) }

        subject { instance.eql?(other) }

        it { subject.must_equal(true) }

        context 'when different to other' do
          let(:other) {
            described.new(colour: Vedeu::Colours::Colour.coerce(background: '#ff0000'))
          }

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

    end # Stream

  end # Views

end # Vedeu

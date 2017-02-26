# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Views

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

      describe '#client' do
        it { instance.must_respond_to(:client) }
      end

      describe '#client=' do
        it { instance.must_respond_to(:client=) }
      end

      describe '#parent=' do
        it { instance.must_respond_to(:parent=) }
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

      describe '#eql?' do
        let(:other) { instance }

        subject { instance.eql?(other) }

        it { subject.must_equal(true) }

        context 'when different to other' do
          let(:other) { described.new(value: [:other]) }

          it { subject.must_equal(false) }
        end
      end

      describe '#==' do
        it { instance.must_respond_to(:==) }
      end

      describe '#size' do
        subject { instance.size }

        it { subject.must_be_instance_of(Integer) }

        it 'returns the size of the line' do
          subject.must_equal(53)
        end
      end

    end # Line

  end # Views

end # Vedeu

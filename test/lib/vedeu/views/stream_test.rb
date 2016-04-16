# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Views

    describe Stream do

      let(:described)  { Vedeu::Views::Stream }
      let(:instance)   { described.new(attributes) }
      let(:attributes) {
        {
          colour: colour,
          name:   _name,
          parent: parent,
          style:  style,
          value:  _value,
        }
      }
      let(:_name)  {}
      let(:_value) { 'Some text' }
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
      let(:style)       { Vedeu::Presentation::Style.new('normal') }
      let(:line_parent) { Vedeu::Views::View.new(name: 'Vedeu::Views::Stream') }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@colour').must_equal(colour) }
        it { instance.instance_variable_get('@name').must_equal(_name) }
        it { instance.instance_variable_get('@parent').must_equal(parent) }
        it { instance.instance_variable_get('@style').must_equal(style) }
        it { instance.instance_variable_get('@value').must_equal(_value) }
      end

      describe '#parent=' do
        it { instance.must_respond_to(:parent=) }
      end

      describe '#value' do
        it { instance.must_respond_to(:value) }
      end

      describe '#content' do
        it { instance.must_respond_to(:content) }
      end

      describe '#text' do
        it { instance.must_respond_to(:text) }
      end

      describe '#value=' do
        it { instance.must_respond_to(:value=) }
      end

      describe '#add' do
        let(:child) { instance }

        subject { instance.add(child) }

        it { subject.must_be_instance_of(Vedeu::Views::Streams) }
      end

      describe '#<<' do
        it { instance.must_respond_to(:<<) }
      end

      describe '#attributes' do
        subject { instance.attributes }

        it { subject.must_be_instance_of(Hash) }
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

      describe '#==' do
        it { instance.must_respond_to(:==) }
      end

      describe '#name' do
        subject { instance.name }

        context 'when a parent is set' do
          it { subject.must_equal('Vedeu::Views::Stream') }
        end

        context 'when a parent is not set' do
          let(:parent) {}

          it { subject.must_equal(nil) }
        end
      end

    end # Stream

  end # Views

end # Vedeu

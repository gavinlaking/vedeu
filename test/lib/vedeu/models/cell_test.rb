require 'test_helper'

module Vedeu

  module Models

    describe Cell do

      let(:described)  { Vedeu::Models::Cell }
      let(:instance)   { described.new(attributes) }
      let(:attributes) {
        {
          colour:   colour,
          name:     _name,
          style:    style,
          value:    _value,
          position: position,
        }
      }
      let(:colour)   { Vedeu::Colours::Colour.new(background: '#000000') }
      let(:_name)    {}
      let(:style)    {}
      let(:_value)   {}
      let(:position) {}

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@colour').must_equal(colour) }
        it { instance.instance_variable_get('@name').must_equal(_name) }
        it { instance.instance_variable_get('@style').must_equal(style) }
        it { instance.instance_variable_get('@value').must_equal('') }
        it { instance.instance_variable_get('@position').must_equal([1, 1]) }
      end

      describe 'accessors' do
        it {
          instance.must_respond_to(:colour)
          instance.must_respond_to(:name)
          instance.must_respond_to(:style)
          instance.must_respond_to(:value)
        }
      end

      describe '#cell?' do
        it { instance.cell?.must_equal(true) }
      end

      describe '#eql?' do
        let(:other) { described.new(value: nil, position: nil) }

        subject { instance.eql?(other) }

        it { subject.must_respond_to(:==) }

        it { subject.must_equal(true) }

        context 'when different to other' do
          let(:other) { described.new(value: 'b', position: [2, 3]) }

          it { subject.must_equal(false) }
        end
      end

      describe '#interface' do
        let(:interface) { Vedeu::Interfaces::Interface.new }

        before do
          Vedeu.interfaces.stubs(:by_name).with(_name).returns(interface)
        end

        subject { instance.interface }

        it { subject.must_be_instance_of(Vedeu::Interfaces::Interface) }
      end

      describe '#position' do
        subject { instance.position }

        it { subject.must_be_instance_of(Vedeu::Geometry::Position) }
      end

      describe '#to_hash' do
        let(:expected) {
          {
            colour:   "\e[48;2;0;0;0m",
            style:    '',
            value:    '',
            position: "\e[1;1H",
          }
        }

        subject { instance.to_hash }

        it { subject.must_be_instance_of(Hash) }
        it { subject.must_equal(expected) }
      end

      describe '#to_html' do
        subject { instance.to_html }

        it { subject.must_be_instance_of(String) }
        it { subject.must_equal('') }
      end

      describe '#to_s' do
        subject { instance.to_s }

        it { subject.must_be_instance_of(String) }
        it { subject.must_equal('') }
      end

    end # Cell

  end # Models

end # Vedeu

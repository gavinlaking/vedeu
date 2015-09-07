require 'test_helper'

module Vedeu

  module Models

    describe Escape do

      let(:described)  { Vedeu::Models::Escape }
      let(:instance)   { described.new(attributes) }
      let(:attributes) {
        {
          value:    _value,
          position: position,
        }
      }
      let(:_value)     { "\e[?25h" }
      let(:position)   { [2, 6] }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@value').must_equal(_value) }
      end

      describe 'accessors' do
        it { instance.must_respond_to(:value) }
      end

      describe '#null' do
        it { instance.null.must_equal(nil) }
        it { instance.background.must_equal(nil) }
        it { instance.colour.must_equal(nil) }
        it { instance.foreground.must_equal(nil) }
        it { instance.style.must_equal(nil) }
      end

      describe '#eql?' do
        let(:other) { instance }

        subject { instance.eql?(other) }

        it { subject.must_equal(true) }

        context 'when different to other' do
          let(:other) { described.new(value: 'b') }

          it { subject.must_equal(false) }
        end

        it { instance.must_respond_to(:==) }
      end

      describe '#position' do
        it { instance.position.must_be_instance_of(Vedeu::Geometry::Position) }
      end

      describe '#position' do
        subject { instance.position }

        it { subject.must_be_instance_of(Vedeu::Position) }
      end

      describe '#value' do
        subject { instance.value }

        it { subject.must_be_instance_of(String) }
        it { subject.must_equal("\e[?25h") }
      end

      describe '#to_html' do
        subject { instance.to_html }

        it { subject.must_be_instance_of(String) }
        it { subject.must_equal('') }
      end

      describe '#to_s' do
        subject { instance.to_s }
        it { subject.must_be_instance_of(String) }
        it { subject.must_equal("\e[2;6H\e[?25h") }

        it { instance.must_respond_to(:to_str) }
      end

    end # Escape

  end # Models

end # Vedeu

# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Cells

    describe Escape do

      let(:described)  { Vedeu::Cells::Escape }
      let(:instance)   { described.new(attributes) }
      let(:attributes) {
        {
          position: position,
          value:    _value,
        }
      }
      let(:position)   { [2, 6] }
      let(:_value)     { "\e[?25h" }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@position').must_equal(position) }
        it { instance.instance_variable_get('@value').must_equal(_value) }
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
      end

      describe '#==' do
        it { instance.must_respond_to(:==) }
      end

      describe '#value' do
        subject { instance.value }

        it { subject.must_be_instance_of(String) }
        it { subject.must_equal("\e[?25h") }
      end

      describe '#text' do
        subject { instance.text }

        it { subject.must_equal('') }
      end

      describe '#to_h' do
        let(:expected) {
          {
            type:  :escape,
            value: "\e[?25h",
          }
        }
        subject { instance.to_h }

        it { subject.must_be_instance_of(Hash) }
        it { subject.must_equal(expected) }
      end

      describe '#to_hash' do
        it { instance.must_respond_to(:to_hash) }
      end

      describe '#to_html' do
        subject { instance.to_html }

        it { subject.must_be_instance_of(String) }
        it { subject.must_equal('') }
      end

      describe '#to_s' do
        subject { instance.to_s }

        it { subject.must_be_instance_of(String) }
        it { subject.must_equal("\e[?25h") }
      end

      describe '#to_str' do
        it { instance.must_respond_to(:to_str) }
      end

      describe '#type' do
        subject { instance.type }

        it { subject.must_equal(:escape) }
      end

    end # Escape

  end # Cells

end # Vedeu

# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Cells

    describe Border do

      let(:described)  { Vedeu::Cells::Border }
      let(:instance)   { described.new(attributes) }
      let(:attributes) {
        {
          value: _value
        }
      }
      let(:_value) {}

      describe '#attributes' do
        subject { instance.attributes }

        it { subject.must_be_instance_of(Hash) }
      end

      describe '#cell?' do
        subject { instance.cell? }

        it { subject.must_equal(false) }
      end

      describe '#name=' do
        subject { instance.name=(_value) }

        # @todo Add more tests.
      end

      describe '#value' do
        subject { instance.value }

        context 'when the value is a horizontal border character' do
          let(:_value) { "\x71" }

          it { subject.must_equal("\e(0q\e(B") }
        end

        context 'when the value is a vertical border character' do
          let(:_value) { "\x78" }

          it { subject.must_equal("\e(0x\e(B") }
        end

        context 'when the value is a corner border character' do
          let(:_value) { "\x6A" }

          it { subject.must_equal("\e(0j\e(B") }
        end

        context 'when the value is nil or empty' do
          it { subject.must_equal('') }
        end
      end

    end # Border

  end # Cells

end # Vedeu

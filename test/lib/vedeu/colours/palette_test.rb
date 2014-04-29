require_relative '../../../test_helper'

module Vedeu
  module Colours
    describe Palette do
      let(:klass)       { Palette }
      let(:default_set) { { normal: 0, reverse: 262144 } }
      let(:colour_name) { :undefined }

      describe '.exists?' do
        subject { klass.exists?(colour_name) }

        context 'when the colour has not been defined' do
          it { subject.must_equal false }
        end

        context 'when the colour has been defined' do
          let(:colour_name) { :normal }

          it { subject.must_equal true }
        end
      end

      describe '.find' do
        subject { klass.find(colour_name) }

        context 'when the colour has not been defined' do
          it { subject.must_equal nil }
        end

        context 'when the colour has been defined' do
          let(:colour_name) { :reverse }

          it { subject.must_equal(262144) }
        end
      end

      describe '.create' do
        let(:colour_name) { :defined }
        let(:colour_pair)  { 256 }
        let(:colour_map)   {
          {
            normal: 0,
            reverse: 262144,
            black: 0,
            red: 1,
            green: 2,
            yellow: 3,
            blue: 4,
            magenta: 5,
            cyan: 6,
            white: 7,
            defined: 256
          }
        }

        before { klass.reset! }

        subject { klass.create(colour_name, colour_pair) }

        it 'returns all the colour map' do
          subject.must_equal(colour_map)
        end
      end

      describe '.next_id' do
        subject { klass.next_id }

        it 'returns the next available ID for Curses.colour_pair' do
          subject.must_equal(12)
        end
      end

    end
  end
end

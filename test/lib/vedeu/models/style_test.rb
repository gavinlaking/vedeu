require 'test_helper'

module Vedeu
  describe Style do
    describe '#initialize' do
      it 'returns an instance of itself' do
        values = ''

        Style.new(values).must_be_instance_of(Style)
      end
    end

    describe '#to_s' do
      describe 'for a single style' do
        let(:values) { 'normal' }

        it 'returns an escape sequence' do
          Style.new(values).to_s.must_equal("\e[24m\e[22m\e[27m")
        end
      end

      describe 'for multiple styles' do
        let(:values) { ['normal', 'underline'] }

        it 'returns an escape sequence for multiple styles' do
          Style.new(values).to_s.must_equal("\e[24m\e[22m\e[27m\e[4m")
        end
      end

      describe 'for an unknown style' do
        let(:values) { 'unknown' }

        it 'returns an empty string for an unknown style' do
          Style.new(values).to_s.must_equal('')
        end
      end

      describe 'for an empty or nil' do
        let(:values) { '' }

        it 'returns an empty string for empty or nil' do
          Style.new(values).to_s.must_equal('')
        end
      end
    end
  end
end

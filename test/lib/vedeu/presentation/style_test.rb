require 'test_helper'

module Vedeu

  describe Style do

    let(:described) { Style.new(values) }
    let(:values)    { ['bold'] }

    describe '#initialize' do
      it { described.must_be_instance_of(Style) }
      it { assigns(described, '@values', values) }
    end

    describe '#attributes' do
      it 'returns an attributes hash for this instance' do
        described.attributes.must_equal({ style: ['bold'] })
      end
    end

    describe '#to_s' do
      it { return_type_for(described.to_s, String) }

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

  end # Style

end # Vedeu

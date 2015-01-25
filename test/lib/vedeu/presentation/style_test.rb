require 'test_helper'

module Vedeu

  describe Style do

    let(:described) { Style }

    describe '#initialize' do
      subject { described.new('bold') }

      it { return_type_for(subject, described) }
      it { subject.instance_variable_get('@value').must_equal('bold') }
    end

    describe '#attributes' do
      subject { described.new('bold').attributes }

      it { return_type_for(subject, Hash) }

      it 'returns an attributes hash for this instance' do
        subject.must_equal({ style: 'bold' })
      end
    end

    describe '#to_s' do
      let(:value) {}

      subject { described.new(value).to_s }

      it { return_type_for(subject, String) }
      it { return_value_for(subject, '') }

      describe 'for a single style' do
        let(:value) { 'normal' }

        it 'returns an escape sequence' do
          subject.must_equal("\e[24m\e[22m\e[27m")
        end
      end

      describe 'for multiple styles' do
        let(:value) { ['normal', 'underline'] }

        it 'returns an escape sequence for multiple styles' do
          subject.must_equal("\e[24m\e[22m\e[27m\e[4m")
        end
      end

      describe 'for an unknown style' do
        let(:value) { 'unknown' }

        it 'returns an empty string for an unknown style' do
          subject.must_equal('')
        end
      end

      describe 'for an empty or nil' do
        let(:value) { '' }

        it 'returns an empty string for empty or nil' do
          subject.must_equal('')
        end
      end
    end

  end # Style

end # Vedeu

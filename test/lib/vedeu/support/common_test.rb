require 'test_helper'

module Vedeu

  describe Common do

    let(:described) { Vedeu::VedeuCommonClass.new }

    describe '#defined_value?' do
      subject { described.defined_value_test(value) }

      context 'when the variable is a Fixnum' do
        let(:value) { 17 }

        it { subject.must_equal(true) }
      end

      context 'when the variable is not nil or empty' do
        let(:value) { 'not empty' }

        it { subject.must_equal(true) }
      end

      context 'when the variable is nil or empty' do
        let(:value) { [] }

        it { subject.must_equal(false) }
      end

      context 'when dealing with keys which may not exist or have a value' do
        let(:attributes) { {} }
        let(:value)      { attributes[:not_found] }

        it { subject.must_equal(false) }
      end
    end

    describe '#requires_block' do
      subject { described.requires_block(:some_method) }

      it { proc { subject }.must_raise(InvalidSyntax) }
    end

    describe '#to_sentence' do
      let(:array) { %w{ hydrogen helium lithium } }

      subject { described.to_sentence(array) }

      it { return_type_for(subject, String) }
      it { return_value_for(subject, 'hydrogen, helium and lithium') }
    end

  end # Common

end # Vedeu

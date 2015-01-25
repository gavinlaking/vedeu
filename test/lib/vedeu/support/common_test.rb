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

    describe '#deprecated' do
      let(:old_method) { '' }
      let(:new_method) { '' }
      let(:version)    { '' }
      let(:hint)       { '' }

      subject { described.deprecated(old_method, new_method, version, hint) }

      it { proc { subject }.must_raise(DeprecationError) }
    end

    describe '#to_sentence' do
      let(:array) { %w{ hydrogen helium lithium } }

      subject { described.to_sentence(array) }

      it { subject.must_be_instance_of(String) }
      it { subject.must_equal('hydrogen, helium and lithium') }
    end

  end # Common

end # Vedeu

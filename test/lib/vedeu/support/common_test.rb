require 'test_helper'

module Vedeu

  class VedeuCommonClass

    include Vedeu::Common

    def defined_value_test(variable)
      defined_value?(variable)
    end

  end # VedeuCommonClass

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

  end # Common

end # Vedeu

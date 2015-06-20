require 'test_helper'

module Vedeu

  class VedeuCommonClass

    include Vedeu::Common

    def defined_value_test(variable)
      present?(variable)
    end

  end # VedeuCommonClass

  describe Common do

    let(:described) { Vedeu::VedeuCommonClass.new }

    describe '#present?' do
      subject { described.defined_value_test(_value) }

      context 'when the variable is a Fixnum' do
        let(:_value) { 17 }

        it { subject.must_equal(true) }
      end

      context 'when the variable is not nil or empty' do
        let(:_value) { 'not empty' }

        it { subject.must_equal(true) }
      end

      context 'when the variable is nil or empty' do
        let(:_value) { [] }

        it { subject.must_equal(false) }
      end

      context 'when dealing with keys which may not exist or have a value' do
        let(:attributes) { {} }
        let(:_value)     { attributes[:not_found] }

        it { subject.must_equal(false) }
      end
    end

  end # Common

end # Vedeu

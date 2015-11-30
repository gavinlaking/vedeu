require 'test_helper'

module Vedeu

  class VedeuCommonClass

    include Vedeu::Common

    def defined_value_test(variable)
      present?(variable)
    end

    def undefined_value_test(variable)
      absent?(variable)
    end

  end # VedeuCommonClass

  describe Common do

    let(:described) { Vedeu::VedeuCommonClass }
    let(:instance)  { described.new }

    describe '#absent?' do
      subject { instance.undefined_value_test(_value) }

      context 'when the variable is a Fixnum' do
        let(:_value) { 17 }

        it { subject.must_equal(false) }
      end

      context 'when the variable is not nil or empty' do
        let(:_value) { 'not empty' }

        it { subject.must_equal(false) }
      end

      context 'when the variable is nil or empty' do
        let(:_value) { [] }

        it { subject.must_equal(true) }
      end

      context 'when dealing with keys which may not exist or have a value' do
        let(:attributes) { {} }
        let(:_value)     { attributes[:not_found] }

        it { subject.must_equal(true) }
      end
    end

    describe '#become' do
      let(:instance)   { Vedeu::Cells::Border.new }
      let(:klass)      { Vedeu::Cells::Char }
      let(:attributes) { instance.attributes }

      subject { instance.become(klass, attributes) }

      it { subject.must_be_instance_of(Vedeu::Cells::Char) }
    end

    describe '#demodulize' do
      let(:klass) { described }

      subject { instance.demodulize(klass) }

      it { subject.must_equal('VedeuCommonClass') }
    end

    describe '#numeric?' do
      let(:_value) {}

      subject { instance.numeric?(_value) }

      context 'when the value is numeric' do
        let(:_value) { 16 }

        it { subject.must_equal(true) }
      end

      context 'when the value is not numeric' do
        it { subject.must_equal(false) }
      end
    end

    describe '#present?' do
      subject { instance.defined_value_test(_value) }

      context 'when the variable is a Fixnum' do
        let(:_value) { 17 }

        it { subject.must_equal(true) }
      end

      context 'when the variable is a Symbol' do
        let(:_value) { :some_value }

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

    describe '#snake_case' do
      let(:_name) { 'MyFirstApp' }

      subject { instance.snake_case(_name) }

      it { subject.must_equal('my_first_app') }

      context 'when namespaced' do
        let(:_name) { 'MyFirstApp::SomeController' }

        it { subject.must_equal('my_first_app/some_controller') }
      end
    end

  end # Common

end # Vedeu

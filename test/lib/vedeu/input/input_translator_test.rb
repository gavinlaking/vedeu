require 'test_helper'

module Vedeu

  describe InputTranslator do

    let(:described) { Vedeu::InputTranslator }
    let(:instance)  { described.new(code) }
    let(:code)      {}

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
      it { instance.instance_variable_get('@code').must_equal(code) }
    end

    describe '.translate' do
      subject { described.translate(code) }

      context 'when the code is not recognised' do
        let(:code) { 'a' }

        it { subject.must_equal('a') }
      end

      context 'when the code is recognised' do
        let(:code) { "\e[H" }

        it { subject.must_equal(:home) }
      end
    end

    describe '#translate' do
      it { instance.must_respond_to(:translate) }
    end

  end # InputTranslator

end # Vedeu

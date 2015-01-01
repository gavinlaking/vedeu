require 'test_helper'

module Vedeu

  describe Composition do

    let(:described) { Vedeu::DSL::Composition.new(model) }
    let(:model)     { Vedeu::Composition.new }

    describe '#initialize' do
      it { return_type_for(described, Vedeu::DSL::Composition) }
      it { assigns(described, '@model', model) }
    end

    describe '#render' do
      it { skip }

      context 'when the block is not given' do
        subject { described.render }

        it { proc { subject }.must_raise(InvalidSyntax) }
      end
    end

    describe '#view' do
      it { skip }

      context 'when the block is not given' do
        subject { described.view }

        it { proc { subject }.must_raise(InvalidSyntax) }
      end
    end

    describe '#views' do
      it { skip }

      context 'when the block is not given' do
        subject { described.views }

        it { proc { subject }.must_raise(InvalidSyntax) }
      end
    end

  end # Composition

end # Vedeu

require 'test_helper'

require 'json'

module Vedeu

  describe Composition do

    let(:described)  { Composition.new(attributes) }
    let(:attributes) { {} }

    before { Buffers.reset }

    describe '#initialize' do
      it { return_type_for(described, Composition) }
      it { assigns(described, '@attributes', { interfaces: [] }) }
    end

    describe '#deputy' do
      it { return_type_for(described.deputy, DSL::Composition) }
    end

    describe '#interfaces' do
      subject { described.interfaces }

      context 'when no interfaces' do
        let(:attributes) { { interfaces: [] } }

        it { return_type_for(subject, Array) }
        it { return_value_for(subject, []) }
      end

      context 'when a single interface' do
        let(:attributes) { { interfaces: [{ name: 'hydrogen' }] } }

        it { return_type_for(subject, Array) }

        it 'returns a single interface object' do
          subject.size.must_equal(1)
        end
      end

      context 'when multiple interfaces' do
        let(:attributes) { { interfaces: [{ name: 'hydrogen' }, { name: 'helium' }] } }

        it { return_type_for(subject, Array) }

        it 'returns multiple interface objects' do
          subject.size.must_equal(2)
        end
      end
    end

    describe '#view_attributes' do
      subject { described.view_attributes }

      it { return_type_for(subject, Hash) }
      it { return_value_for(subject, {}) }
    end

  end # Composition

end # Vedeu

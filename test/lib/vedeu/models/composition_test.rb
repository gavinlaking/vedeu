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

    describe '#interfaces' do
      it 'returns a collection of interfaces' do
        Vedeu.interface('dummy') do
          width  5
          height 5
        end
        Composition.new({
          interfaces: {
            name:  'dummy',
            lines: []
          }
        }).interfaces.first.must_be_instance_of(Interface)
      end

      it 'returns an empty collection when no interfaces are associated' do
        described.interfaces.must_be_empty
      end
    end

    describe '#method_missing' do
      it 'returns nil' do
        described.some_missing_method(:test).must_equal(nil)
      end
    end

  end # Composition

end # Vedeu

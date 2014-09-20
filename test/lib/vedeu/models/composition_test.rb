require 'test_helper'

require 'json'

module Vedeu
  describe Composition do
    before { Buffers.reset }

    describe '#initialize' do
      it 'returns an instance of itself' do
        attributes = {}

        Composition.new(attributes).must_be_instance_of(Composition)
      end
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
        Composition.new.interfaces.must_be_empty
      end
    end

  end
end

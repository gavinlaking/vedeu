require 'test_helper'

module Vedeu

  describe Interfaces do

    describe '#add' do
      before { Interfaces.reset }

      it 'adds the interface to the storage' do
        Interfaces.add({ name: 'germanium' })
        Interfaces.all.must_equal({ 'germanium' => { name: 'germanium' } })
      end

      it 'raises an exception if the attributes does not have a :name key' do
        attributes = { no_name_key: '' }

        proc { Interfaces.add(attributes) }.must_raise(MissingRequired)
      end
    end

    describe '#build' do
      let(:attributes) { { name: 'rhenium' } }

      before { Interfaces.add(attributes) }
      after  { Interfaces.reset }

      it 'returns a new instance of Interface based on the stored attributes' do
        Interfaces.build('rhenium').must_be_instance_of(Interface)
      end

      context 'when the interface cannot be found' do
        it 'raises an exception' do
          proc { Interfaces.build('manganese') }.must_raise(InterfaceNotFound)
        end
      end
    end

    describe '#reset' do
      before { Interfaces.reset }

      it 'removes all known interfaces from the storage' do
        Interfaces.add({ name: 'bromine' })
        Interfaces.all.must_equal({ 'bromine' => { name: 'bromine' } })
        Interfaces.reset.must_be_empty
      end
    end

  end # Interfaces

end # Vedeu

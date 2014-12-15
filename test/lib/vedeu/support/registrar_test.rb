require 'test_helper'

module Vedeu

  describe Registrar do

    let(:described)  { Registrar.new(attributes) }
    let(:attributes) {
      {
        name:  'mendelevium',
        group: 'elements'
      }
    }

    before do
      Buffers.reset
      Interfaces.reset
      Groups.reset
      Focus.reset
    end

    describe '.record' do
      it 'raises an exception if the attributes does not have a :name key' do
        attributes = { no_name_key: '' }

        proc { Registrar.record(attributes) }.must_raise(MissingRequired)
      end

      it 'raises an exception if the value for :name is nil' do
        attributes = { name: nil }

        proc { Registrar.record(attributes) }.must_raise(MissingRequired)
      end

      it 'raises an exception if the value for :name is empty' do
        attributes = { name: '' }

        proc { Registrar.record(attributes) }.must_raise(MissingRequired)
      end

      it 'sends the attributes to the Buffers repository' do
        Registrar.record(attributes)

        Buffers.registered?('mendelevium').must_equal(true)
      end

      it 'sends the attributes to the Offsets repository' do
        Registrar.record(attributes)

        Offsets.registered?('mendelevium').must_equal(true)
      end

      it 'sends the attributes to the Interfaces repository' do
        Registrar.record(attributes)

        Interfaces.registered?('mendelevium').must_equal(true)
      end

      it 'sends the attributes to the Cursors repository' do
        Registrar.record(attributes)

        Cursors.registered?('mendelevium').must_equal(true)
      end

      it 'sends the attributes to the Groups repository' do
        Registrar.record(attributes)

        Groups.registered?('elements').must_equal(true)
      end

      it 'sends the attributes to the Focus repository' do
        Registrar.record(attributes)

        Focus.registered?('mendelevium').must_equal(true)
      end

    end

    describe '.reset!' do
      it { Registrar.reset!.must_be_instance_of(TrueClass) }

      it 'removes all entities from all repositories' do
        skip
      end
    end

    describe '#initialize' do
      it { return_type_for(described, Registrar) }
      it { assigns(described, '@attributes', attributes) }
    end

  end # Registrar

end # Vedeu

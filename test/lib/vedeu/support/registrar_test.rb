require 'test_helper'

module Vedeu

  describe Registrar do

    it { skip }

    # let(:described)  { Registrar.new(attributes) }
    # let(:attributes) {
    #   {
    #     name:  'mendelevium',
    #     group: 'elements'
    #   }
    # }

    # before do
    #   Buffers.reset
    #   Interfaces.reset
    #   Groups.reset
    #   Focus.reset
    # end

    # describe '.record' do
    #   context 'when the attributes do not have a :name key' do
    #     attributes = { no_name_key: '' }

    #     it { proc { Registrar.record(attributes) }.must_raise(MissingRequired) }
    #   end

    #   context 'when the value for :name is nil' do
    #     attributes = { name: nil }

    #     it { proc { Registrar.record(attributes) }.must_raise(MissingRequired) }
    #   end

    #   context 'when the value for :name is empty' do
    #     attributes = { name: '' }

    #     it { proc { Registrar.record(attributes) }.must_raise(MissingRequired) }
    #   end

    #   it 'sends the attributes to the Buffers repository' do
    #     Registrar.record(attributes)

    #     Buffers.registered?('mendelevium').must_equal(true)
    #   end

    #   it 'sends the attributes to the Interfaces repository' do
    #     Registrar.record(attributes)

    #     Interfaces.registered?('mendelevium').must_equal(true)
    #   end

    #   it 'sends the attributes to the Cursors repository' do
    #     Registrar.record(attributes)

    #     Cursors.registered?('mendelevium').must_equal(true)
    #   end

    #   it 'sends the attributes to the Groups repository' do
    #     Registrar.record(attributes)

    #     Groups.registered?('elements').must_equal(true)
    #   end

    #   it 'sends the attributes to the Focus repository' do
    #     Registrar.record(attributes)

    #     Focus.registered?('mendelevium').must_equal(true)
    #   end
    # end

    # describe '.reset!' do
    #   it { Registrar.reset!.must_be_instance_of(TrueClass) }
    # end

    # describe '#initialize' do
    #   it { return_type_for(described, Registrar) }
    #   it { assigns(described, '@attributes', attributes) }
    # end

  end # Registrar

end # Vedeu

require_relative '../../../test_helper'
require_relative '../../../../lib/vedeu/repository/interface_repository'

module Vedeu
  describe InterfaceRepository do
    let(:described_class) { InterfaceRepository }

    before do
      InterfaceRepository.create({
        name: 'dummy',
        width: 15,
        height: 2
      })
    end
    after { InterfaceRepository.reset }

    describe '.create' do
      let(:subject)    { described_class.create(attributes) }
      let(:attributes) {
        {
          name: 'dummy',
          width: 15,
          height: 2
        }
      }

      it 'returns an Interface' do
        subject.must_be_instance_of(Interface)
      end
    end

    describe '.find' do
      let(:subject) { described_class.find(value) }
      let(:value)   { 'dummy' }

      context 'when the interface exists' do
        it 'returns an Interface' do
          subject.must_be_instance_of(Interface)
        end
      end

      context 'when the interface does not exist' do
        before { InterfaceRepository.reset }

        it 'raises an exception' do
          proc { subject }.must_raise(UndefinedInterface)
        end
      end
    end

    describe '.refresh' do
      let(:subject) { described_class.refresh }

      it 'returns an Array' do
        subject.must_be_instance_of(Array)
      end
    end

    describe '.by_layer' do
      let(:subject) { described_class.by_layer }

      before do
        InterfaceRepository.reset
        @case_a = InterfaceRepository.create({ name: 'a', width: 15, height: 2, z: 2 })
        @case_b = InterfaceRepository.create({ name: 'b', width: 15, height: 2, z: 1 })
        @case_c = InterfaceRepository.create({ name: 'c', width: 15, height: 2, z: 3 })
      end
      after  { InterfaceRepository.reset }

      it 'returns an Array' do
        subject.must_be_instance_of(Array)
      end

      it 'returns the collection in order they should be drawn' do
        subject.must_equal([@case_b, @case_a, @case_c])
      end
    end

    describe '.entity' do
      let(:subject) { described_class.entity }

      it 'returns a Class instance' do
        subject.must_be_instance_of(Class)
      end

      it 'returns Interface' do
        subject.must_equal(Interface)
      end
    end
  end
end

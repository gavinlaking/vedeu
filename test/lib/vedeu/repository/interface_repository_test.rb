require_relative '../../../test_helper'

module Vedeu
  describe InterfaceRepository do
    let(:described_class) { InterfaceRepository }

    before { Interface.create({ name: 'dummy', width: 15, height: 2 }) }
    after  { InterfaceRepository.reset }

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

      before { Compositor.stubs(:arrange) }

      it 'returns an Array' do
        subject.must_be_instance_of(Array)
      end
    end

    describe '.entity' do
      let(:subject) { described_class.entity }

      it 'returns an Interface' do
        subject.must_equal(Interface)
      end
    end

    describe '.by_layer' do
      let(:subject) { described_class.by_layer }

      before do
        InterfaceRepository.reset
        @case_a = Interface.create({ name: 'a', width: 15, height: 2, layer: 1 })
        @case_b = Interface.create({ name: 'b', width: 15, height: 2, layer: 0 })
        @case_c = Interface.create({ name: 'c', width: 15, height: 2, layer: 2 })
      end
      after  { InterfaceRepository.reset }

      it 'returns an Array' do
        subject.must_be_instance_of(Array)
      end

      it 'returns the collection in order they should be drawn' do
        subject.must_equal([@case_b, @case_a, @case_c])
      end
    end
  end
end

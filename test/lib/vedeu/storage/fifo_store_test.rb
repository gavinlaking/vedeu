require 'test_helper'

module Vedeu

  describe FifoStore do

    let(:described) { Vedeu::FifoStore }
    let(:instance)  { described.new(storage) }
    let(:storage)   { [] }

    describe '#initialize' do
      it { instance.must_be_instance_of(Vedeu::FifoStore) }
      it { instance.instance_variable_get('@storage').must_equal(storage) }
    end

    describe '#load' do
      subject { instance.load }

      context 'when the storage is empty' do
        it { subject.must_equal(nil) }
      end

      context 'when the storage is not empty' do
        let(:storage) { [:lithium, :helium, :hydrogen] }

        it { subject.must_equal(:hydrogen) }

        it 'removes the item from storage on retrieval' do
          instance.size.must_equal(3)
          subject
          instance.size.must_equal(2)
        end
      end
    end

    describe '#save' do
      let(:data)    { :beryllium }
      let(:storage) { [:lithium, :helium, :hydrogen] }

      subject { instance.save(data) }

      it { subject.must_equal([:beryllium, :lithium, :helium, :hydrogen]) }
    end

  end # FifoStore

end # Vedeu

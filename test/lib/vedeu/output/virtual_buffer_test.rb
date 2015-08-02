require 'test_helper'

module Vedeu

  describe VirtualBuffer do

    let(:described) { Vedeu::VirtualBuffer }

    before { described.clear }

    describe '#retrieve' do
      subject { described.retrieve }

      context 'when no buffers are stored' do
        it { subject.must_be_instance_of(NilClass) }
      end

      context 'when buffers are stored' do
        let(:buffer) { [[Vedeu::Views::Char.new]] }

        before { described.store(buffer) }

        it { subject.must_be_instance_of(Array) }

        it { subject.must_equal(buffer) }

        it 'removes the stored buffer from the storage' do
          described.size.must_equal(1)
          subject
          described.size.must_equal(0)
        end
      end
    end

    describe '#store' do
      let(:data) { :data }

      subject { described.store(data) }

      it { subject.must_be_instance_of(Array) }

      it { subject.must_equal([:data]) }

      it 'adds the buffer (data) to the storage' do
        described.size.must_equal(0)
        subject
        described.size.must_equal(1)
      end
    end

    describe '#size' do
      subject { described.size }

      it { subject.must_be_instance_of(Fixnum) }
    end

    describe '#clear' do
      subject { described.clear }

      it { subject.must_be_instance_of(Array) }

      it { subject.must_be_empty }

      it { described.must_respond_to(:reset) }
    end

  end # VirtualBuffer

end # Vedeu

require 'test_helper'

module Vedeu

  describe Buffers do

    let(:described) { Vedeu::Buffers }
    let(:instance)  { described.buffers }

    describe '.buffers' do
      subject { instance }

      it { subject.must_be_instance_of(described) }
    end

    describe '#by_name' do
      let(:_name) { 'carbon' }

      subject { described.buffers.by_name(_name) }

      context 'when the buffer exists' do
        before do
          Vedeu.interface 'carbon' do
          end
        end
        after { Vedeu.buffers.reset }

        it { subject.must_be_instance_of(Vedeu::Buffer) }
      end

      context 'when the buffer does not exist' do
        let(:_name) { 'nitrogen' }

        it { subject.must_be_instance_of(Vedeu::Null::Buffer) }
      end
    end

  end # Buffers

end # Vedeu

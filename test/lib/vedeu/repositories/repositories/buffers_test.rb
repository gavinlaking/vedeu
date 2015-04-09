require 'test_helper'

module Vedeu

  describe Buffers do

    let(:described) { Vedeu::Buffers }
    let(:instance)  { described.buffers }

    describe '.buffers' do
      subject { instance }

      it { subject.must_be_instance_of(described) }
    end

    describe '#clear' do
      let(:_name)  { 'silicon' }
      let(:buffer) { Vedeu::Buffer.new }

      subject { instance.clear(_name) }

      context 'when the buffer exists' do
        before { instance.stubs(:find!).returns(buffer) }

        it { buffer.expects(:clear); subject }
      end

      context 'when the buffer does not exist' do
        it { proc { subject }.must_raise(ModelNotFound) }
      end
    end

    describe '#render' do
      let(:_name) { 'silicon' }
      let(:buffer) { Vedeu::Buffer.new }

      subject { instance.render(_name) }

      context 'when the buffer exists' do
        before { instance.stubs(:find!).returns(buffer) }

        it { buffer.expects(:render); subject }
      end

      context 'when the buffer does not exist' do
        it { proc { subject }.must_raise(ModelNotFound) }
      end
    end

  end # Buffers

end # Vedeu

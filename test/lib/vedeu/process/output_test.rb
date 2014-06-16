require_relative '../../../test_helper'

module Vedeu
  describe Output do
    let(:described_class) { Output }
    let(:subject)         { described_class.new(result) }
    let(:result)          {}
    let(:queued_result)   { { 'dummy' => [['queued...']] } }

    before do
      Interface.create({ name: 'dummy', width: 10, height: 2 })
      Queue.stubs(:dequeue).returns(queued_result)
    end

    it 'returns an Output instance' do
      subject.must_be_instance_of(Output)
    end

    it 'sets an instance variable' do
      subject.instance_variable_get("@result").must_equal(result)
    end

    describe '.render' do
      let(:subject) { described_class.render(result) }

      context 'when no result is provided' do
        before { Compositor.stubs(:arrange).returns('queued...') }

        context 'and the queue contains data' do
          it 'returns a String' do
            subject.must_be_instance_of(String)
          end

          it 'returns the correct output' do
            subject.must_equal('queued...')
          end
        end

        context 'and the queue is empty' do
          before { Queue.stubs(:dequeue) }

          it 'returns a NilClass' do
            subject.must_be_instance_of(NilClass)
          end
        end
      end

      context 'when a result is provided' do
        let(:result) { { 'dummy' => [['normal...']] } }

        before { Compositor.stubs(:arrange).returns('normal...') }

        it 'returns a String' do
          subject.must_be_instance_of(String)
        end

        it 'returns the correct output' do
          subject.must_equal('normal...')
        end

        context 'but the queue contains data' do
          before { Queue.stubs(:dequeue).returns(queued_result) }

          it 'ignores the queued data' do
            subject.must_equal('normal...')
          end
        end
      end
    end
  end
end

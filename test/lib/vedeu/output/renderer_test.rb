require_relative '../../../test_helper'

module Vedeu
  describe Renderer do
    let(:described_class)    { Renderer }
    let(:described_instance) { described_class.new(composition) }
    let(:composition)        { [] }

    it 'returns a Renderer instance' do
      described_instance.must_be_instance_of(Renderer)
    end

    describe '.write' do
      let(:subject) { described_class.write(composition) }

      it 'returns an Array' do
        subject.must_be_instance_of(Array)
      end

      it 'returns an empty array' do
        subject.must_equal([])
      end

      context 'capturing i/o' do
        let(:captured) { capture_io { subject }.join }

        it 'returns a String' do
          captured.must_be_instance_of(String)
        end

        it 'returns an empty string' do
          captured.must_equal("")
        end
      end
    end
  end
end

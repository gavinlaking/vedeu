require_relative '../../../test_helper'

module Vedeu
  describe Renderer do
    let(:described_class)    { Renderer }
    let(:described_instance) { described_class.new(composition) }
    let(:composition)        { [] }

    it { described_instance.must_be_instance_of(Renderer) }

    describe '.write' do
      let(:subject) { described_class.write(composition) }

      it { subject.must_be_instance_of(Array) }

      it { subject.must_equal([]) }

      context 'capturing i/o' do
        let(:captured) { capture_io { subject }.join }

        it { captured.must_be_instance_of(String) }

        it { captured.must_equal("") }
      end
    end
  end
end

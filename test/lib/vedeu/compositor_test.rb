require_relative '../../test_helper'

module Vedeu
  describe Compositor do
    let(:klass)    { Compositor }
    let(:instance) { klass.new(output, options) }
    let(:output)   { [] }
    let(:options)  { {} }

    it { instance.must_be_instance_of(Vedeu::Compositor) }

    describe '.write' do
      subject { klass.write(output, options) }

      it { subject.must_be_instance_of(NilClass) }

      context 'capturing output' do
        let(:io) { capture_io { subject }.join }

        it { io.must_be_instance_of(String) }
      end
    end
  end
end

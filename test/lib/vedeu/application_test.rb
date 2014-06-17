require_relative '../../test_helper'

module Vedeu
  describe Application do
    let(:described_class)    { Application }
    let(:described_instance) { described_class.new(options) }
    let(:options)            { {} }

    it 'returns an Application instance' do
      described_instance.must_be_instance_of(Application)
    end

    describe '.start' do
      let(:subject) { described_class.start(options) }

      before do
        Terminal.stubs(:open).yields(self)
        Output.stubs(:render)
        EventLoop.stubs(:main_sequence)
        Terminal.stubs(:close)
      end

      it 'returns a NilClass' do
        subject.must_be_instance_of(NilClass)
      end
    end
  end
end

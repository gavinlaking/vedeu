require_relative '../../test_helper'
require_relative '../../../lib/vedeu/application'

module Vedeu
  describe Application do
    let(:described_class)    { Application }
    let(:described_instance) { described_class.new(options) }
    let(:options)            { {} }

    describe '#initialize' do
      let(:subject) { described_class.new(options) }

      it 'returns an Application instance' do
        subject.must_be_instance_of(Application)
      end
    end

    describe '.start' do
      let(:subject) { described_class.start(options) }

      before do
        Terminal.stubs(:open).yields(self)
        Output.stubs(:render)
        Input.stubs(:capture)
        Process.stubs(:evaluate)
        Terminal.stubs(:close)
      end

      context 'when the application should run interactively' do
        let(:options) { { interactive: true } }

        before { Process.stubs(:evaluate).raises(StopIteration) }

        it 'returns a NilClass' do
          subject.must_be_instance_of(NilClass)
        end
      end

      context 'when the application should run once' do
        let(:options) { { interactive: false } }

        it 'returns a NilClass' do
          subject.must_be_instance_of(NilClass)
        end
      end
    end
  end
end

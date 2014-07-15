require_relative '../../test_helper'
require_relative '../../../lib/vedeu/application'

module Vedeu
  describe Application do
    let(:options) { {} }

    describe '#initialize' do
      def subject
        Application.new(options)
      end

      it 'returns an Application instance' do
        subject.must_be_instance_of(Application)
      end
    end

    describe '.start' do
      def subject
        Application.start(options)
      end

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

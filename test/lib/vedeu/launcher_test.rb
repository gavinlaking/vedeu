require_relative '../../test_helper'
require_relative '../../../lib/vedeu/launcher'

module Vedeu
  describe Launcher do
    let(:argv) { [] }

    before { Application.stubs(:start) }

    describe '#initialize' do
      def subject
        Launcher.new(argv)
      end

      it 'returns a Launcher instance' do
        subject.must_be_instance_of(Launcher)
      end
    end

    describe '#execute!' do
      def subject
        Launcher.new(argv).execute!
      end

      it 'needs a spec, please write one.' do
        skip
      end
    end
  end
end

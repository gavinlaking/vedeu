require_relative '../../test_helper'

module Vedeu
  describe Launcher do
    let(:described_class)    { Launcher }
    let(:described_instance) { described_class.new(argv) }
    let(:argv)               { [] }

    before { Application.stubs(:start) }

    describe '#initialize' do
      let(:subject) { described_class.new(argv) }

      it 'returns a Launcher instance' do
        subject.must_be_instance_of(Launcher)
      end
    end

    describe '#execute!' do
      let(:subject) { described_instance.execute! }
    end
  end
end

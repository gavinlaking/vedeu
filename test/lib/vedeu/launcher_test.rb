require_relative '../../test_helper'

module Vedeu
  describe Launcher do
    let(:described_class)    { Launcher }
    let(:described_instance) { described_class.new(argv) }
    let(:argv)               { [] }

    it { described_instance.must_be_instance_of(Launcher) }

    describe '#execute!' do
      let(:subject) { described_instance.execute! }
    end
  end
end

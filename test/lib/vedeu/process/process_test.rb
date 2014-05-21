require_relative '../../../test_helper'

module Vedeu
  describe Process do
    let(:described_class) { Process }
    let(:instance)        { described_class.new }

    it { instance.must_be_instance_of(Process) }
  end
end

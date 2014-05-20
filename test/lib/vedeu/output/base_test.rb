require_relative '../../../test_helper'

module Vedeu
  describe Base do
    let(:described_class) { Base }
    let(:instance) { described_class.new }

    it { instance.must_be_instance_of(Base) }
  end
end

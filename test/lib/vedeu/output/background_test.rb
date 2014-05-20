require_relative '../../../test_helper'

module Vedeu
  describe Background do
    let(:described_class) { Background }
    let(:instance) { described_class.new }

    it { instance.must_be_instance_of(Background) }
  end
end

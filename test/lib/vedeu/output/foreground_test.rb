require_relative '../../../test_helper'

module Vedeu
  describe Foreground do
    let(:described_class)    { Foreground }
    let(:instance) { described_class.new }

    it { instance.must_be_instance_of(Foreground) }
  end
end

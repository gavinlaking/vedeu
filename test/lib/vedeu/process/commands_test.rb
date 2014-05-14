require_relative '../../../test_helper'

module Vedeu
  describe Commands do
    let(:klass)    { Commands }
    let(:instance) { klass.instance }
    let(:block)    {}

    it { instance.must_be_instance_of(Vedeu::Commands) }
  end
end

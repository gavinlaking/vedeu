require_relative '../../../test_helper'

module Vedeu
  describe Dummy do
    let(:klass)    { Dummy }
    let(:instance) { klass.new }

    it { instance.must_be_instance_of(Dummy) }
  end
end

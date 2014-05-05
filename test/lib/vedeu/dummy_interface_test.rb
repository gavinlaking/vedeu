require_relative '../../test_helper'

module Vedeu
  describe DummyInterface do
    let(:klass)    { DummyInterface }
    let(:instance) { klass.new }

    it { instance.must_be_instance_of(DummyInterface) }
  end
end

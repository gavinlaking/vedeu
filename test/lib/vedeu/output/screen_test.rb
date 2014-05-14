require_relative '../../../test_helper'

module Vedeu
  describe Screen do
    let(:klass)    { Screen }
    let(:instance) { klass.new }
    let(:block)    {}

    it { instance.must_be_instance_of(Vedeu::Screen) }
  end
end

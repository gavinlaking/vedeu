require_relative '../../../test_helper'

module Vedeu
  describe Background do
    let(:klass) { Background }
    let(:instance) { klass.new }

    it { instance.must_be_instance_of(Background) }
  end
end

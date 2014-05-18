require_relative '../../../test_helper'

module Vedeu
  describe Process do
    let(:klass)    { Process }
    let(:instance) { klass.new }
    let(:block)    {}

    it { instance.must_be_instance_of(Vedeu::Process) }
  end
end

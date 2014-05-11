require_relative '../../../test_helper'

module Vedeu
  module Process
    describe Commands do
      let(:klass)    { Commands }
      let(:instance) { klass.instance }
      let(:block)    {}

      subject { instance }

      it { subject.must_be_instance_of(Vedeu::Process::Commands) }
    end
  end
end

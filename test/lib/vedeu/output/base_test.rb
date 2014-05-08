require_relative '../../../test_helper'

module Vedeu
  module Output
    describe Base do
      let(:klass) { Base }
      let(:instance) { klass.new }

      it { instance.must_be_instance_of(Output::Base) }
    end
  end
end

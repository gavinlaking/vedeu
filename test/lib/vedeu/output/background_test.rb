require_relative '../../../test_helper'

module Vedeu
  module Output
    describe Background do
      let(:klass) { Background }
      let(:instance) { klass.new }

      it { instance.must_be_instance_of(Output::Background) }
    end
  end
end

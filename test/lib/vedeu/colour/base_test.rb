require_relative '../../../test_helper'

module Vedeu
  module Colour
    describe Base do
      let(:klass) { Base }
      let(:instance) { klass.new }

      it { instance.must_be_instance_of(Colour::Base) }
    end
  end
end

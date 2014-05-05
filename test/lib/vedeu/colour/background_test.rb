require_relative '../../../test_helper'

module Vedeu
  module Colour
    describe Background do
      let(:klass) { Background }
      let(:instance) { klass.new }

      it { instance.must_be_instance_of(Colour::Background) }
    end
  end
end

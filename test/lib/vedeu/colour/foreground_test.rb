require_relative '../../../test_helper'

module Vedeu
  module Colour
    describe Foreground do
      let(:klass)    { Foreground }
      let(:instance) { klass.new }

      it { instance.must_be_instance_of(Colour::Foreground) }
    end
  end
end

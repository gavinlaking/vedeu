require 'test_helper'

module Vedeu

  describe Buffers do

    let(:described) { Vedeu::Buffers }
    let(:instance)  { described.buffers }

    it { described.must_respond_to(:buffers) }

  end # Buffers

end # Vedeu

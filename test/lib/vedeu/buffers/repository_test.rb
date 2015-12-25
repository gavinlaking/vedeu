# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Buffers

    describe Repository do

      let(:described) { Vedeu::Buffers::Repository }
      let(:instance)  { described.buffers }

      it { described.must_respond_to(:buffers) }

    end # Repository

  end # Buffers

end # Vedeu

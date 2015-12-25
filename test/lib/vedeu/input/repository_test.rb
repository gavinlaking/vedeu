# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Input

    describe Repository do

      let(:described) { Vedeu::Input::Repository }

      it { described.must_respond_to(:keymaps) }

    end # Repository

  end # Input

end # Vedeu

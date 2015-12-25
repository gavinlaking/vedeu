# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Borders

    describe Repository do

      let(:described) { Vedeu::Borders::Repository }

      it { described.must_respond_to(:borders) }

    end # Repository

  end # Borders

end # Vedeu

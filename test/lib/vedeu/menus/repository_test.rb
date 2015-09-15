require 'test_helper'

module Vedeu

  module Menus

    describe Repository do

      let(:described) { Vedeu::Menus::Repository }

      it { described.must_respond_to(:menus) }

    end # Repository

  end # Menus

end # Vedeu

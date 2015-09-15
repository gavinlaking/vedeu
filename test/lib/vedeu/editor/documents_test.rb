require 'test_helper'

module Vedeu

  module Editor

    describe Documents do

      let(:described) { Vedeu::Editor::Documents }

      it { described.must_respond_to(:documents) }

    end # Documents

  end # Editor

end # Vedeu

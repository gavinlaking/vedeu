require 'test_helper'

module Vedeu

  module Editor

    describe Repository do

      let(:described) { Vedeu::Editor::Repository }

      it { described.must_respond_to(:documents) }

    end # Repository

  end # Editor

end # Vedeu

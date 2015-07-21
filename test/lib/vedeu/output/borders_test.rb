require 'test_helper'

module Vedeu

  describe Borders do

    let(:described) { Vedeu::Borders }

    after { Vedeu.borders.reset! }

    it { described.must_respond_to(:borders) }

  end # Borders

end # Vedeu

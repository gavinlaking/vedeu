require 'test_helper'

module Vedeu

  class OptionsTest

    extend Vedeu::Options

  end # OptionsTest

  describe Options do

    let(:described) { Vedeu::Options }

    let(:including_described) { Vedeu::OptionsTest }
    let(:including_instance)  { including_described.new }

    it { including_described.must_respond_to(:option) }

    # @todo Add more tests.

  end # Options

end # Vedeu

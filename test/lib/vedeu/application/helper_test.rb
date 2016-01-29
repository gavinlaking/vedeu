# frozen_string_literal: true

require 'test_helper'

module Vedeu

  class HelperTestClass

    include Vedeu::Helper

  end # HelperTestClass

  describe Helper do

    let(:described)          { Vedeu::Helper }
    let(:included_described) { Vedeu::HelperTestClass }
    let(:included_instance)  { included_described.new }

    # @todo Add more tests.

  end # Helper

end # Vedeu

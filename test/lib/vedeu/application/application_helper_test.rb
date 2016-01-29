# frozen_string_literal: true

require 'test_helper'

module Vedeu

  class ApplicationHelperTestClass

    include Vedeu::ApplicationHelper

  end

  describe ApplicationHelper do

    let(:described)          { Vedeu::ApplicationHelper }
    let(:included_described) { Vedeu::ApplicationHelperTestClass }
    let(:included_instance)  { included_described.new }

    # @todo Add more tests.

  end # Application

end # Vedeu

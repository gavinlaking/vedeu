require 'test_helper'

module Vedeu

  class ApplicationHelperTestClass

    include Vedeu::ApplicationHelper

  end

  describe ApplicationHelper do

    let(:described) { Vedeu::ApplicationHelper }
    let(:instance)  { Vedeu::ApplicationHelperTestClass.new }

  end # Application

end # Vedeu

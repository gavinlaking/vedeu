require 'test_helper'

module Vedeu

  class ViewTestClass

    include Vedeu::View

  end # ViewTestClass

  describe View do

    let(:described) { Vedeu::ViewTestClass }
    let(:instance)  { described.new }

    # @todo

  end # View

end # Vedeu

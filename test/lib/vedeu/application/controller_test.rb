require 'test_helper'

module Vedeu

  class ControllerTestClass

    include Vedeu::Controller

  end # ControllerTestClass

  describe Controller do

    let(:described) { Vedeu::ControllerTestClass }
    let(:instance)  { described.new }

    context 'ClassMethods' do

    end

  end # Controller

end # Vedeu

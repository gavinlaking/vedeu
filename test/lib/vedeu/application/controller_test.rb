require 'test_helper'

module Vedeu

  class ControllerTestClass

    include Vedeu::Controller

  end # ControllerTestClass

  describe Controller do

    let(:described) { Vedeu::ControllerTestClass }
    let(:instance)  { described.new }

    context 'ClassMethods' do
      let(:_name) { :vedeu_controller_test }

      subject { ControllerTestClass.controller_name(_name) }

      it {
        Vedeu.expects(:bind).with(:show_vedeu_controller_test)
        subject
      }
    end

  end # Controller

end # Vedeu

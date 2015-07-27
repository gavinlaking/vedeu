require 'test_helper'

module Vedeu

  class ControllerTestKlass

    include Vedeu::Controller

    controller :some_controller
    action :some_action

  end # ControllerTestClass

  describe Controller do

    let(:described) { Vedeu::Controller }

    let(:described_model) { Vedeu::ControllerTestKlass }
    let(:instance_model)  { described.new }

    describe 'ClassMethods' do
      let(:described) { Vedeu::Controller::ClassMethods }

      it { described_model.must_respond_to(:controller_name) }
      it { described_model.must_respond_to(:action_name) }
      it { described_model.must_respond_to(:controller) }
      it { described_model.must_respond_to(:action) }

      describe '.controller' do
        subject { described_model.controller(:some_controller) }

        it {
          Vedeu::Router.expects(:add_controller).
            with(:some_controller, 'Vedeu::ControllerTestKlass')
          subject
        }
      end

      describe '.action' do
        subject { described_model.action(:some_action, :other_action) }

        it {
          Vedeu::Router.expects(:add_action).
            with(:some_controller, :some_action)
          Vedeu::Router.expects(:add_action).
            with(:some_controller, :other_action)
          subject
        }
      end

    end # ClassMethods

  end # Controller

end # Vedeu

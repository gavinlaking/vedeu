require 'test_helper'

module Vedeu

  module Bindings

	  describe Application do

      context 'the application specific events are defined' do
        it { Vedeu.bound?(:_action_).must_equal(true) }
      end

      describe '.action!' do
        let(:controller) { :some_controller }
        let(:action)     { :show_basket }
        let(:args)       {
          {
            customer_id: 3,
            product_id: 16,
          }
        }

        before { Vedeu::Router.stubs(:goto) }

        subject { Vedeu.trigger(:_action_, controller, action, **args) }

        it {
          Vedeu::Router.expects(:goto)
            .with(:some_controller, :show_basket, args)
          subject
        }
      end

	  end # Application

  end # Bindings

end # Vedeu

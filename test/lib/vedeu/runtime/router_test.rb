require 'test_helper'

module Vedeu

  class SomeController

    def some_action(customer_id:, product_id:)
      {
        customer: { name: 'Gavin Laking', customer_id: customer_id },
        basket:   { product_ids: [product_id] }
      }
    end

  end # SomeController

	describe Router do

    let(:described) { Vedeu::Router }

    before { described.reset! }

    describe '.add_controller' do
      let(:controller_name) {}
      let(:klass) { "SomeController" }

      subject { described.add_controller(controller_name, klass) }

      context 'when a name is not given' do
        it { proc { subject }.must_raise(Vedeu::MissingRequired) }
      end

      context 'when a name is given' do
        let(:controller_name) { :some_controller }

        context 'when the controller is registered' do
          before {
            described.add_controller(controller_name, '')
            described.add_action(controller_name, :show_basket)
          }
          after  { described.reset! }

          it {
            subject.must_equal({
              some_controller: {
                klass:   'SomeController',
                actions: [:show_basket]
              }
            })
          }
        end

        context 'when the controller is not registered' do
          it {
            subject.must_equal({
              some_controller: {
                klass:   'SomeController',
                actions: []
              }
            })
          }
        end
      end
    end

    describe '.add_action' do
      let(:controller_name) {}
      let(:action_name)     {}

      subject { described.add_action(controller_name, action_name) }

      context 'when the controller is not given' do
        let(:action_name) { :some_action }

        it { proc { subject }.must_raise(Vedeu::MissingRequired) }
      end

      context 'when the name is not given' do
        let(:controller_name) { :some_controller }

        it { proc { subject }.must_raise(Vedeu::MissingRequired) }
      end

      context 'when the controller and name is given' do
        let(:controller_name) { :some_controller }
        let(:action_name) { :some_action }

        context 'when the controller is registered' do
          before { described.add_controller(controller_name, 'SomeController') }
          after  { described.reset! }

          it {
            subject.must_equal({
              some_controller: {
                klass:   'SomeController',
                actions: [:some_action]
              }
            })
          }
        end

        context 'when the controller is not registered' do
          before { described.reset! }

          it {
            subject.must_equal({
              some_controller: {
                klass:   '',
                actions: [:some_action]
              }
            })
          }
        end
      end
    end

    describe '.goto' do
      let(:controller_name) { :some_controller }
      let(:action_name)     { :some_action }
      let(:args)            {
        {
          customer_id: 7,
          product_id:  88,
        }
      }

      subject { described.goto(controller_name, action_name, **args) }

      it { described.must_respond_to(:action) }

      context 'when the controller is registered' do
        context 'when the controller klass is defined' do
          before {
            described.add_controller(controller_name, 'Vedeu::SomeController')
            described.add_action(controller_name, action_name)
          }
          after { described.reset! }

          it {
            subject.must_equal({
              customer: {
                name: 'Gavin Laking',
                customer_id: 7
              },
              basket: {
                product_ids: [88]
              }
            })
          }
        end

        context 'when the action is not defined for this controller' do
          let(:action_name) { :undefined_action }

          before {
            described.add_controller(controller_name, 'Vedeu::SomeController')
          }

          it { proc { subject }.must_raise(Vedeu::ActionNotFound) }
        end

        context 'when the controller klass is not defined' do
          before {
            described.add_controller(controller_name, '')
            described.add_action(controller_name, action_name)
          }
          after { described.reset! }

          it { proc { subject }.must_raise(Vedeu::MissingRequired) }
        end
      end

      context 'when the controller is not registered' do
        it { proc { subject }.must_raise(Vedeu::ControllerNotFound) }
      end
    end

    describe '.registered' do
      let(:controller_name) { :some_controller }

      subject { described.registered?(controller_name) }

      context 'when the controller is registered' do
        before { described.add_controller(controller_name, "SomeController") }
        after  { described.reset! }

        it { subject.must_equal(true) }
      end

      context 'when the controller is not registered' do
        it { subject.must_equal(false) }
      end
    end

    describe '.reset!' do
      subject { described.reset! }

      it { subject.must_equal({}) }

      it { described.must_respond_to(:reset) }
    end

	end # Router

end # Vedeu

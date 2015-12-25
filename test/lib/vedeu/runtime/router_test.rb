# frozen_string_literal: true

require 'test_helper'

module Vedeu

  class SomeController < Vedeu::ApplicationController

    def some_action
      {
        customer: { name: 'Gavin Laking', customer_id: params[:customer_id] },
        basket:   { product_ids: [params[:product_id]] }
      }
    end

  end # SomeController

  describe 'Bindings' do
    it { Vedeu.bound?(:_goto_).must_equal(true) }
    # it { Vedeu.bound?(:_action_).must_equal(true) }
  end

  module Runtime

    describe Router do

      let(:described) { Vedeu::Runtime::Router }

      before { described.reset! }

      describe '.add_controller' do
        let(:controller) {}
        let(:klass) { "SomeController" }

        before { Vedeu.stubs(:log) }

        subject { described.add_controller(controller, klass) }

        context 'when a name is not given' do
          it { proc { subject }.must_raise(Vedeu::Error::MissingRequired) }
        end

        context 'when a name is given' do
          let(:controller) { :some_controller }

          context 'when the controller is registered' do
            before do
              described.add_controller(controller, '')
              described.add_action(controller, :show_basket)
            end
            after  { described.reset! }

            it do
              subject.must_equal({
                some_controller: {
                  klass:   'SomeController',
                  actions: [:show_basket]
                }
              })
            end
          end

          context 'when the controller is not registered' do
            it do
              subject.must_equal({
                some_controller: {
                  klass:   'SomeController',
                  actions: []
                }
              })
            end
          end
        end
      end

      describe '.add_action' do
        let(:controller) {}
        let(:action)     {}

        before { Vedeu.stubs(:log) }

        subject { described.add_action(controller, action) }

        context 'when the controller is not given' do
          let(:action) { :some_action }

          it { proc { subject }.must_raise(Vedeu::Error::MissingRequired) }
        end

        context 'when the name is not given' do
          let(:controller) { :some_controller }

          it { proc { subject }.must_raise(Vedeu::Error::MissingRequired) }
        end

        context 'when the controller and name is given' do
          let(:controller) { :some_controller }
          let(:action) { :some_action }

          context 'when the controller is registered' do
            before { described.add_controller(controller, 'SomeController') }
            after  { described.reset! }

            it do
              subject.must_equal({
                some_controller: {
                  klass:   'SomeController',
                  actions: [:some_action]
                }
              })
            end
          end

          context 'when the controller is not registered' do
            before { described.reset! }

            it do
              subject.must_equal({
                some_controller: {
                  klass:   '',
                  actions: [:some_action]
                }
              })
            end
          end
        end
      end

      # describe '.goto!' do
      #   let(:controller) { :some_controller }
      #   let(:action)     { :show_basket }
      #   let(:args)       {
      #     {
      #       customer_id: 3,
      #       product_id: 16,
      #     }
      #   }

      #   before { Vedeu::Runtime::Router.stubs(:goto) }

      #   subject { Vedeu.trigger(:_goto_, controller, action, **args) }

      #   it do
      #     Vedeu::Runtime::Router.expects(:goto)
      #       .with(:some_controller, :show_basket, args)
      #     subject
      #   end
      # end

      describe '.goto' do
        let(:controller) { :some_controller }
        let(:action)     { :some_action }
        let(:args)            {
          {
            customer_id: 7,
            product_id:  88,
          }
        }

        before { Vedeu.stubs(:log) }

        subject { described.goto(controller, action, **args) }

        it { described.must_respond_to(:action) }

        context 'when the controller is registered' do
          context 'when the controller klass is defined' do
            before do
              described.add_controller(controller, 'Vedeu::SomeController')
              described.add_action(controller, action)
            end
            after { described.reset! }

            it do
              subject.must_equal({
                customer: {
                  name: 'Gavin Laking',
                  customer_id: 7
                },
                basket: {
                  product_ids: [88]
                }
              })
            end
          end

          context 'when the action is not defined for this controller' do
            let(:action) { :undefined_action }

            before do
              described.add_controller(controller, 'Vedeu::SomeController')
            end

            it { proc { subject }.must_raise(Vedeu::Error::ActionNotFound) }
          end

          context 'when the controller klass is not defined' do
            before do
              described.add_controller(controller, '')
              described.add_action(controller, action)
            end
            after { described.reset! }

            it { proc { subject }.must_raise(Vedeu::Error::MissingRequired) }
          end
        end

        context 'when the controller is not registered' do
          it { proc { subject }.must_raise(Vedeu::Error::ControllerNotFound) }
        end
      end

      describe '.registered' do
        let(:controller) { :some_controller }

        subject { described.registered?(controller) }

        context 'when the controller is registered' do
          before { described.add_controller(controller, "SomeController") }
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

  end # Runtime

end # Vedeu

# frozen_string_literal: true

module Vedeu

  # Provides methods to be used by {Vedeu::ApplicationController}.
  #
  module Controller

    # @macro module_singleton_methods
    module SingletonMethods

      attr_writer :controller_name

      # Specifying the controller name in your controller provides
      # Vedeu with the means to route requests to different parts of
      # your application.
      #
      # @example
      #   class YourController
      #
      #     controller :your_controller
      #     # or...
      #     controller_name :your_controller
      #
      #     # ... some code
      #
      #   end
      #
      # @param controller_name [Symbol] The name of the controller.
      # @return
      #   [Hash<Symbol => Hash<Symbol => String, Array<Symbol>>>]
      def controller(controller_name = nil)
        @controller_name = controller_name

        Vedeu::Runtime::Router.add_controller(controller_name,
                                              ancestors[0].to_s)
      end
      alias controller_name controller

      # Specifying the action names in your controller provides Vedeu
      # with the means to route requests to different parts of your
      # application.
      #
      # @example
      #   class YourController
      #
      #     controller :your_controller
      #
      #     action :show
      #     # or...
      #     actions :show, :list
      #     # or...
      #     action_name :show
      #
      #     # ... some code
      #
      #   end
      #
      #   Vedeu.trigger(:_goto_,
      #                 :your_controller,
      #                 :show,
      #                 { some: :args })
      #
      # @param action_names [Array<Symbol>, Symbol] A collection of
      #   action names or the name of the action.
      # @return [Array<Symbol>]
      def action(*action_names)
        action_names.each do |action_name|
          Vedeu::Runtime::Router.add_action(@controller_name, action_name)
        end
      end
      alias action_name action
      alias actions action

    end # SingletonMethods

    # @macro module_included
    def self.included(klass)
      klass.extend(Vedeu::Controller::SingletonMethods)
    end

  end # Controller

end # Vedeu

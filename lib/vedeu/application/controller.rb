module Vedeu

  # Provides methods to be used by Vedeu::ApplicationController.
  #
  module Controller

    # When included, provide these methods as class methods.
    #
    module ClassMethods

      attr_accessor :controller_name

      # Specifying the controller name in your controller provides Vedeu with
      # the means to route requests to different parts of your application.
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
      # @return [void]
      def controller(controller_name = nil)
        @controller_name = controller_name

        Vedeu::Router.add_controller(controller_name, ancestors.first.to_s)
      end
      alias_method :controller_name, :controller

      # Specifying the action names in your controller provides Vedeu with the
      # means to route requests to different parts of your application.
      #
      # @example
      #   class YourController
      #
      #     controller :your_controller
      #
      #     action :show
      #     # or...
      #     action_name :show
      #
      #     # ... some code
      #
      #   end
      #
      #   Vedeu.trigger(:_action_, :your_controller, :show, { some: :args })
      #
      # @param action_name [Symbol] THe name of the action.
      # @return [void]
      def action(action_name = nil)
        Vedeu::Router.add_action(@controller_name, action_name)
      end
      alias_method :action_name, :action

    end # ClassMethods

    # When this module is included in a class, provide ClassMethods as class
    # methods for the class.
    #
    # @param klass [Class]
    # @return [void]
    def self.included(klass)
      klass.send :extend, ClassMethods
    end

  end # Controller

end # Vedeu

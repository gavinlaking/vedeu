module Vedeu

  # Provides methods to be used by Vedeu::ApplicationController.
  #
  module Controller

    # When included, provide these methods as class methods.
    module ClassMethods

      # Specifying the controller name in your controller provides a Vedeu event
      # which will trigger the loading of the controller.
      #
      # @example
      #   class YourController
      #     controller_name :your_controller
      #     # ...
      #   end
      #
      #   Vedeu.trigger(:show_your_controller) # this event is now available to
      #                                        # trigger.
      #
      # @param name [Symbol] The name of the controller.
      # @return [void]
      # @todo This event binding should be: `Vedeu.bind(:show_view, name)`.
      def controller_name(name)
        Vedeu.bind("show_#{name}".to_sym) { new }
      end

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

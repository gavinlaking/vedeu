module Vedeu

  # Provides methods to be used by Vedeu::ApplicationController.
  #
  # @api private
  module Controller

    # When included, provide these methods as class methods.
    module ClassMethods

      # @param name [Symbol] The name of the controller.
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

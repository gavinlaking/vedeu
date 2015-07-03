module Vedeu

  module Controller

    module ClassMethods

      def controller_name(name)
        Vedeu.bind("show_#{name}".to_sym) { self.new }
      end

    end # ClassMethods

    module InstanceMethods
    end # InstanceMethods

    # When this module is included in a class, provide ClassMethods as class
    # methods for the class.
    #
    # @param klass [Class]
    # @return [void]
    def self.included(klass)
      klass.send :extend, ClassMethods
      klass.send :include, InstanceMethods
    end

  end # Controller

end # Vedeu

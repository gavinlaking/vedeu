module Vedeu

  module Controller

    module ClassMethods
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

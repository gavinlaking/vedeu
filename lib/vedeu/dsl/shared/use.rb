module Vedeu

  module DSL

    # Provides helper methods for building views.
    #
    module Use

      extend self

      # Use the specified interface; useful for sharing attributes with other
      # interfaces. Any public method of {Vedeu::Interface} is available.
      #
      # @example
      #   Vedeu.interface 'my_interface' do
      #     # use the delay of another interface
      #     delay Vedeu.use('my_other_interface').delay
      #     # ...
      #   end
      #
      #   Vedeu.interface 'my_interface' do
      #     geometry do
      #       # use the width of another interface
      #       width Vedeu.use('my_other_interface').width
      #       # ...
      #     end
      #   end
      #
      #   Vedeu.use('my_other_interface').width # can be used in your code to
      #                                         # get this value
      #
      # @param value [String] The name of the interface you wish to use.
      #   Typically used when defining interfaces to share geometry.
      # @return [Vedeu::Interface]
      def use(value)
        if Vedeu.interfaces.registered?(value) == false
          fail ModelNotFound, "The properties of this interface (#{value}) " \
                              "cannot be used, since the interface has not " \
                              "been defined."
        end

        Vedeu.interfaces.find(value)
      end

    end # Use

  end # DSL

end # Vedeu

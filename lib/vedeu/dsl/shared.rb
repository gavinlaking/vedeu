module Vedeu

  module DSL

    # Provide shared functionality for various aspects of the DSL.
    #
    module Shared

      extend self

      # Use the specified interface; useful for sharing attributes with other
      # interfaces. Any public method of #{Vedeu::Interface} is available.
      #
      # @example
      #   interface 'my_interface' do
      #     delay use('my_other_interface').delay # use the delay of another
      #     ...                                   # interface
      #
      #   interface 'my_interface' do
      #     geometry do
      #       width use('my_other_interface').width # use the width of another
      #       ...                                   # interface
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

    end # Shared

  end # DSL

end # Vedeu

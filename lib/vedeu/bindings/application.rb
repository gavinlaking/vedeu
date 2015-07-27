module Vedeu

  module Bindings

    # System events relating to movement of cursors or interfaces.
    #
    # :nocov:
    module Application

      extend self

      # Setup events relating to client applications. This method is called by
      # Vedeu.
      #
      # @return [void]
      def setup!
        goto!
      end

      private

      # Call a client application controller's action with parameters.
      #
      # @example
      #   Vedeu.trigger(:_goto_, :your_controller, :some_action, { id: 7 })
      #   Vedeu.goto(:your_controller, :some_action, { id: 7 })
      #
      # @return [void]
      def goto!
        Vedeu.bind(:_goto_) do |controller, action, **args|
          Vedeu::Router.goto(controller, action, **args)
        end

        # @todo Remove this aliasing event. (GL 2015-07-26)
        Vedeu.bind(:_action_) do |controller, action, **args|
          Vedeu.trigger(:_goto_, controller, action, **args)
        end
      end

    end # Application
    # :nocov:

  end # Bindings

end # Vedeu

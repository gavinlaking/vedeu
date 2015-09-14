module Vedeu

  module Bindings

    # System events relating to movement of cursors or interfaces.
    #
    # :nocov:
    module Application

      extend self

      # Setup events relating to client applications. This method is
      # called by Vedeu.
      #
      # @return [TrueClass]
      def setup!
        goto!
      end

      private

      # Call a client application controller's action with parameters.
      #
      # @example
      #   Vedeu.trigger(:_goto_,
      #                 :your_controller,
      #                 :some_action,
      #                 { id: 7 })
      #   Vedeu.goto(:your_controller, :some_action, { id: 7 })
      #
      # @return [TrueClass]
      def goto!
        Vedeu.bind(:_goto_) do |controller, action, **args|
          Vedeu::Router.goto(controller, action, **args)
        end

        Vedeu.bind_alias(:_action_, :_goto_)
      end

    end # Application
    # :nocov:

  end # Bindings

end # Vedeu

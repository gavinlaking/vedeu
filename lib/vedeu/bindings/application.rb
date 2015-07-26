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
        action!
      end

      private

      # @example
      #   Vedeu.trigger(:_action_, :your_controller, :some_action, { id: 7 })
      #
      # @return [void]
      def action!
        Vedeu.bind(:_action_) do |controller, action, **args|
          Vedeu::Router.goto(controller, action, **args)
        end
      end

    end # Application

  end # Bindings

end # Vedeu


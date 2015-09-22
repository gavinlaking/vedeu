module Vedeu

  module Bindings

    # System events relating to movement of cursors or interfaces.
    #
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

      # :nocov:

      # See {file:docs/events/application.md#\_goto_}
      def goto!
        Vedeu.bind(:_goto_) do |controller, action, **args|
          Vedeu::Runtime::Router.goto(controller, action, **args)
        end

        Vedeu.bind_alias(:_action_, :_goto_)
      end

      # :nocov:

    end # Application

  end # Bindings

end # Vedeu

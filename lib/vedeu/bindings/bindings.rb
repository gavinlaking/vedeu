module Vedeu

  module Bindings

    extend self

    # Setup events for running Vedeu. This method is called by Vedeu.
    #
    # @return [TrueClass]
    def setup!
      Vedeu::Events::Repository.reset!

      Vedeu::Bindings::Application.setup!
      Vedeu::Bindings::Document.setup!
      Vedeu::Bindings::DRB.setup!
      Vedeu::Bindings::Focus.setup!
      Vedeu::Bindings::Menus.setup!
      Vedeu::Bindings::Movement.setup!
      Vedeu::Bindings::Refresh.setup!
      Vedeu::Bindings::System.setup!
      Vedeu::Bindings::View.setup!
      Vedeu::Bindings::Visibility.setup!

      true
    end

    # Setup aliases for certain registered events.
    # This method is called by Vedeu.
    #
    # @return [TrueClass]
    def setup_aliases!
      Vedeu::Bindings::Application.setup_aliases!
      Vedeu::Bindings::Movement.setup_aliases!
      Vedeu::Bindings::Visibility.setup_aliases!

      true
    end

  end # Bindings

  Vedeu::Bindings.setup!
  Vedeu::Bindings.setup_aliases!

end # Vedeu

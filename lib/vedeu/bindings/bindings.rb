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
      Vedeu::Bindings::Visibility.setup!
      Vedeu::Bindings::Movement.setup!
      Vedeu::Bindings::Menus.setup!
      Vedeu::Bindings::DRB.setup!
      Vedeu::Bindings::Focus.setup!
      Vedeu::Bindings::Refresh.setup!
      Vedeu::Bindings::System.setup!

      true
    end

  end # Bindings

end # Vedeu

Vedeu::Bindings.setup!

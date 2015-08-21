module Vedeu

  # Binds various events for running and manipulating Vedeu.
  #
  # @note
  #   The methods these modules use are private, and should not be called
  #   directly, however the produced events are all public and are highly
  #   recommended to be used.
  #
  module Bindings

    extend self

    # Setup events for running Vedeu. This method is called by Vedeu.
    #
    # @return [TrueClass]
    def setup!
      Vedeu::Events.reset!

      Vedeu::Bindings::Application.setup!
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

require 'vedeu/bindings/visibility'
require 'vedeu/bindings/movement'
require 'vedeu/bindings/menus'
require 'vedeu/bindings/drb'
require 'vedeu/bindings/system'

module Vedeu

  # Binds various events for running and manipulating Vedeu.
  #
  # @note
  #   The methods these modules use are private, and should not be called
  #   directly, however the produced events are all public and are highly
  #   recommended to be used.
  #
  # @api private
  module Bindings

    # Setup events for running Vedeu. This method is called by Vedeu.
    #
    # @return [void]
    def self.setup!
      Vedeu::Bindings::Visibility.setup!
      Vedeu::Bindings::Movement.setup!
      Vedeu::Bindings::Menus.setup!
      Vedeu::Bindings::DRB.setup!
      Vedeu::Bindings::System.setup!
    end

  end # Bindings

end # Vedeu

Vedeu::Bindings.setup!

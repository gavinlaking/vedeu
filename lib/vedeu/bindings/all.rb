require_relative 'visibility'
require_relative 'movement'
require_relative 'menus'
require_relative 'drb'
require_relative 'system'

module Vedeu

  module Bindings

    # Setup events for running Vedeu.
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

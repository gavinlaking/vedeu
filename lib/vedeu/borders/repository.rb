# frozen_string_literal: true

module Vedeu

  module Borders

    # Allows the storing of interface/view borders independent of the
    # interface instance.
    #
    class Repository < Vedeu::Repositories::Repository

      singleton_class.send(:alias_method, :borders, :repository)

      null Vedeu::Borders::Border, enabled: false
      real Vedeu::Borders::Border

    end # Repository

  end # Borders

  # {include:file:docs/dsl/by_method/borders.md}
  # @api public
  # @!method borders
  # @return [Vedeu::Borders::Repository]
  def_delegators Vedeu::Borders::Repository,
                 :borders

end # Vedeu

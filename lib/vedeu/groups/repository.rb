# frozen_string_literal: true

module Vedeu

  module Groups

    # Allows the storing of view groups.
    #
    class Repository < Vedeu::Repositories::Repository

      null Vedeu::Groups::Group
      real Vedeu::Groups::Group

    end # Groups

    class Group

      repo Vedeu::Groups::Repository.repository

    end # Group

  end # Groups

  # Manipulate the repository of groups.
  #
  # @example
  #   Vedeu.groups
  #
  # @api public
  # @!method groups
  # @return [Vedeu::Groups::Repository]
  def_delegators Vedeu::Groups::Repository,
                 :groups

end # Vedeu

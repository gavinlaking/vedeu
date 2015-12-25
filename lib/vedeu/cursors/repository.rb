# frozen_string_literal: true

module Vedeu

  module Cursors

    # Allows the storing of each interface's cursor.
    #
    class Repository < Vedeu::Repositories::Repository

      singleton_class.send(:alias_method, :cursors, :repository)

      class << self

        # Fetch the cursor of the currently focussed interface/view.
        #
        # @example
        #   Vedeu.cursor
        #
        # @return [NilClass|Vedeu::Cursors::Cursor]
        def cursor
          cursors.by_name
        end

      end # Eigenclass

      null Vedeu::Cursors::Cursor
      real Vedeu::Cursors::Cursor

    end # Repository

    class Cursor

      repo Vedeu::Cursors::Repository.repository

    end # Cursor

  end # Cursors

  # Manipulate the repository of cursors.
  #
  # @example
  #   Vedeu.cursors
  #
  # @!method cursors
  #   @return [Vedeu::Cursors::Repository]
  # @!method cursor
  #   @see Vedeu::Cursors::Repository.cursor
  def_delegators Vedeu::Cursors::Repository,
                 :cursor,
                 :cursors

end # Vedeu

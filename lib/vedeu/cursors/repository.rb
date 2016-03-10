# frozen_string_literal: true

module Vedeu

  module Cursors

    # Allows the storing of each interface's cursor.
    #
    class Repository < Vedeu::Repositories::Repository

      class << self

        # {include:file:docs/dsl/by_method/cursor.md}
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

  # {include:file:docs/dsl/by_method/cursors.md}
  # @api public
  # @!method cursors
  #   @return [Vedeu::Cursors::Repository]
  def_delegators Vedeu::Cursors::Repository,
                 :cursors

  # {include:file:docs/dsl/by_method/cursor.md}
  # @api public
  # @!method cursor
  #   @see Vedeu::Cursors::Repository.cursor
  def_delegators Vedeu::Cursors::Repository,
                 :cursor

end # Vedeu

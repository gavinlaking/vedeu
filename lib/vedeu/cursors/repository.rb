module Vedeu

  module Cursors

    # Allows the storing of each interface's cursor.
    #
    class Repository < Vedeu::Repositories::Repository

      singleton_class.send(:alias_method, :cursors, :repository)

      class << self

        # @return [Vedeu::Cursors::Cursor]
        # @see Vedeu::API::External.cursor
        def cursor
          cursors.by_name(Vedeu.focus) if Vedeu.focus
        end

      end # Eigenclass

      null Vedeu::Cursors::Cursor
      real Vedeu::Cursors::Cursor

    end # Repository

    class Cursor

      repo Vedeu::Cursors::Repository.repository

    end # Cursor

  end # Cursors

end # Vedeu

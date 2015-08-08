module Vedeu

  # Allows the storing of each interface's cursor.
  #
  class Cursors < Vedeu::Repository

    singleton_class.send(:alias_method, :cursors, :repository)

    class << self

      # @return [Vedeu::Cursor]
      # @see Vedeu::API.cursor
      def cursor
        cursors.by_name(Vedeu.focus) if Vedeu.focus
      end

    end # Eigenclass

    null Vedeu::Cursor
    real Vedeu::Cursor

  end # Cursors

  class Cursor

    repo Vedeu::Cursors.repository

  end # Cursor

end # Vedeu

require 'vedeu/cursor/cursor'

module Vedeu

  # Allows the storing of each interface's cursor.
  #
  # @api public
  class Cursors < Vedeu::Repository

    class << self

      alias_method :cursors, :repository

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

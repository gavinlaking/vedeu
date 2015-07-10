require 'vedeu/cursor/cursor'

module Vedeu

  # Allows the storing of each interface's cursor.
  #
  # @api public
  class Cursors < Repository

    class << self

      alias_method :cursors, :repository

      # @return [Vedeu::Cursor]
      # @see Vedeu::API.cursor
      def cursor
        cursors.by_name(Vedeu.focus) if Vedeu.focus
      end

    end # Eigenclass

    real Vedeu::Cursor

    # @example
    #   Vedeu.cursors.by_name('some_name')
    #
    # @param name [String] The name of the stored cursor.
    # @return [Vedeu::Cursor]
    def by_name(name)
      if registered?(name)
        find(name)

      elsif name
        Vedeu::Cursor.new(name: name).store

      else
        Vedeu::Cursor.new(name: Vedeu.focus).store

      end
    end

  end # Cursors

end # Vedeu

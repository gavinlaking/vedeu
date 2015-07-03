module Vedeu

  # Allows the storing of each interface's cursor.
  #
  # @api public
  class Cursors < Repository

    class << self

      # @example
      #   Vedeu.cursors
      #
      # @return [Vedeu::Cursors]
      alias_method :cursors, :repository

      # @example
      #   Vedeu.cursor
      #
      # @return [Vedeu::Cursor]
      def cursor
        cursors.by_name(Vedeu.focus) if Vedeu.focus
      end

      # Remove all stored models from the repository.
      #
      # @example
      #   Vedeu.cursors.reset
      #
      # @return [Vedeu::Cursors]
      def reset!
        @cursors = register(Vedeu::Cursor)
      end

    end

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

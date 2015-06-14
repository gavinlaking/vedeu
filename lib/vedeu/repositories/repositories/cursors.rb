module Vedeu

  # Allows the storing of each interface's cursor.
  class Cursors < Repository

    class << self

      # @return [Vedeu::Cursors]
      alias_method :cursors, :repository

      # @return [Vedeu::Cursor]
      def cursor
        cursors.by_name(Vedeu.focus) if Vedeu.focus
      end

      # Remove all stored models from the repository.
      #
      # @return [Vedeu::Cursors]
      def reset!
        @cursors = register(Vedeu::Cursor)
      end

    end

    # @param name [String] The name of the stored cursor.
    # @return [Vedeu::Cursor]
    def by_name(name)
      if registered?(name)
        find(name)

      elsif name
        Vedeu::Cursor.new(name: name).store

      end
    end

  end # Cursors

end # Vedeu

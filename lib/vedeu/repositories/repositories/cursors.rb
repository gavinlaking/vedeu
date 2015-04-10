module Vedeu

  # Allows the storing of each interface's cursor.
  #
  class Cursors < Repository

    # @return [Vedeu::Cursors]
    def self.cursors
      @cursors ||= reset!
    end

    # @return [Vedeu::Cursor]
    def self.cursor
      cursors.by_name(Vedeu.focus) if Vedeu.focus
    end

    # @return [Vedeu::Cursors]
    def self.repository
      Vedeu.cursors
    end

    # @return [Vedeu::Cursors]
    def self.reset!
      @cursors = Vedeu::Cursors.register_repository(Vedeu::Cursor)
    end

    # @param name [String] The name of the stored cursor.
    # @return [Vedeu::Cursor]
    def by_name(name)
      if registered?(name)
        find(name)

      else
        Vedeu::Cursor.new(name: name).store

      end
    end

  end # Cursors

end # Vedeu

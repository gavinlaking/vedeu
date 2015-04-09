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
      cursors.current
    end

    # @return [Vedeu::Cursors]
    def self.repository
      Vedeu.cursors
    end

    # @return [Vedeu::Cursors]
    def self.reset!
      @cursors = Vedeu::Cursors.register_repository(Vedeu::Cursor)
    end

  end # Cursors

end # Vedeu

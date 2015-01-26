module Vedeu

  # The basis of a fake input device.
  class Read

    # @param console []
    # @param data [String|NilClass]
    # @return [String]
    def self.from(console, data = nil)
      new(console, data).read
    end

    # @param console []
    # @param data [String|NilClass]
    # @return [Vedeu::Read]
    def initialize(console, data = nil)
      @console = console
      @data    = data
    end

    def getch
    end

    def gets
    end

    def read_nonblock(bytes = 1)
    end

    # @return [String]
    def read
      if data
        data

      else
        ''

      end
    end

    private

    attr_reader :console, :data

  end # Read

end # Vedeu

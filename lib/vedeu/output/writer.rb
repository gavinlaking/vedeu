module Vedeu

  # Provides access to all possible mechanisms to write content.
  #
  # @note
  #   Will be used to translate output into HTML, etc.
  #
  class Writer

    attr_reader :writers

    # @param args []
    # @return [Vedeu::Writer]
    def self.[](*args)
      new(args)
    end

    # @param writers []
    # @return [Vedeu::Writer]
    def initialize(writers)
      @writers = writers
    end

    # @param other []
    # @return [Boolean]
    def ==(other)
      writers == other.writers
    end

    # @param other []
    # @return [Vedeu::Writer]
    def +(other)
      Writer[*(writers + other.writers)]
    end

    # @param stream []
    # @return [Array]
    def write(stream)
      @writers.each { |writer| writer.write(stream) }
    end

  end # Writer

end # Vedeu

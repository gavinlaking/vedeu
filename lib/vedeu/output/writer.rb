module Vedeu

  class Writer

    attr_reader :writers

    # @return [Vedeu::Writer]
    def self.[](*args)
      new(args)
    end

    # @return [Vedeu::Writer]
    def initialize(writers)
      @writers = writers
    end

    def ==(other)
      writers == other.writers
    end

    # @return [Vedeu::Writer]
    def +(other)
      Writer[*(writers + other.writers)]
    end

    def write(stream)
      @writers.each { |writer| writer.write(stream) }
    end

  end # Consoles

end # Vedeu

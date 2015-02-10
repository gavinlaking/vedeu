module Vedeu

  class Writer

    attr_reader :writers

    def self.[](*args)
      new(args)
    end

    def initialize(writers)
      @writers = writers
    end

    def ==(other)
      writers == other.writers
    end

    def +(other)
      Writer[*(writers + other.writers)]
    end

    def write(stream)
      @writers.each { |writer| writer.write(stream) }
    end

  end # Consoles

end # Vedeu

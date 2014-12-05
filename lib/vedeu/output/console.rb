module Vedeu

  class Console

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
      Console[*(writers + other.writers)]
    end

    def write(stream)
      @writers.each { |writer| writer.write(stream) }
    end

  end # Consoles

end # Vedeu

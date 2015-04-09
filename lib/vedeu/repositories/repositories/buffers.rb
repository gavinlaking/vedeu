module Vedeu

  # Allows the storing of view buffers.
  #
  class Buffers < Repository

    # @return [Vedeu::Buffers]
    def self.buffers
      @buffers ||= reset!
    end

    # @return [Vedeu::Buffers]
    def self.repository
      Vedeu.buffers
    end

    # @return [Vedeu::Buffers]
    def self.reset!
      @buffers = Vedeu::Buffers.register_repository(Vedeu::Buffer)
    end

    # @param name [String] The name of buffer to clear.
    # @return [void]
    def clear(name)
      find!(name).clear
    end

    # @param name [String] The name of buffer to render.
    # @return [void]
    def render(name)
      find!(name).render
    end

  end # Buffers

end # Vedeu

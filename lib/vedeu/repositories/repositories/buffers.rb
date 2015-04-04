module Vedeu

  # Allows the storing of view buffers.
  #
  class Buffers < Repository

    # @return [Vedeu::Buffers]
    def self.buffers
      @buffers ||= reset!
    end

    def self.repository
      Vedeu.buffers
    end

    def self.reset!
      @buffers = Vedeu::Buffers.register_repository(Vedeu::Buffer)
    end

    def render(name)
      find!(name).render
    end

  end # Buffers

end # Vedeu

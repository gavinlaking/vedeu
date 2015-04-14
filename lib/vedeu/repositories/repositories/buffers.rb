module Vedeu

  # Allows the storing of view buffers.
  #
  class Buffers < Repository

    class << self

      # @return [Vedeu::Buffers]
      def buffers
        @buffers ||= reset!
      end
      alias_method :repository, :buffers

      # @return [Vedeu::Buffers]
      def reset!
        @buffers = Vedeu::Buffers.register_repository(Vedeu::Buffer)
      end

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

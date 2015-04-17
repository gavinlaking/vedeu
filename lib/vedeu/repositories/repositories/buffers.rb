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

    # @param name [String] The name of the stored buffer.
    # @return [Vedeu::Buffer|Vedeu::Null::Buffer]
    def by_name(name)
      if registered?(name)
        find(name)

      else
        Vedeu::Null::Buffer.new(name)

      end
    end

  end # Buffers

end # Vedeu

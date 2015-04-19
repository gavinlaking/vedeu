module Vedeu

  # Allows the storing of view buffers.
  class Buffers < Repository

    class << self

      # @return [Vedeu::Buffers]
      def buffers
        @buffers ||= reset!
      end
      alias_method :repository, :buffers

      # Remove all stored models from the repository.
      #
      # @return [Vedeu::Buffers]
      def reset!
        @buffers = Vedeu::Buffers.register_repository(Vedeu::Buffer)
      end

    end

    null Vedeu::Null::Buffer

  end # Buffers

end # Vedeu

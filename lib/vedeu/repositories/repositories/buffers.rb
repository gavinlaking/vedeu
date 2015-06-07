module Vedeu

  # Allows the storing of view buffers.
  class Buffers < Repository

    class << self

      # @return [Vedeu::Buffers]
      alias_method :buffers, :repository

      # Remove all stored models from the repository.
      #
      # @return [Vedeu::Buffers]
      def reset!
        @buffers = register(Vedeu::Buffer)
      end

    end

    null Vedeu::Null::Buffer
    # real Vedeu::Buffer

  end # Buffers

end # Vedeu

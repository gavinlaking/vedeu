module Vedeu

  # Allows the storing of view buffers.
  #
  # @api public
  class Buffers < Repository

    class << self

      alias_method :buffers, :repository

      # Remove all stored models from the repository.
      #
      # @example
      #   Vedeu.buffers.reset!
      #
      # @return [Vedeu::Buffers]
      def reset!
        @buffers = register(Vedeu::Buffer)
      end

    end # Eigenclass

    null Vedeu::Null::Buffer
    # real Vedeu::Buffer

  end # Buffers

end # Vedeu

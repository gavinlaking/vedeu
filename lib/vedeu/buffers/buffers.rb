module Vedeu

  # Allows the storing of view buffers.
  #
  class Buffers < Vedeu::Repository

    class << self

      alias_method :buffers, :repository

    end # Eigenclass

    null Vedeu::Null::Buffer
    real Vedeu::Buffer

  end # Buffers

  class Buffer

    repo Vedeu::Buffers.repository

  end # Buffer

end # Vedeu

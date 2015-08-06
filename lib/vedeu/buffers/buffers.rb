module Vedeu

  # Allows the storing of view buffers.
  #
  class Buffers < Vedeu::Repository

    singleton_class.send(:alias_method, :buffers, :repository)

    null Vedeu::Null::Buffer
    real Vedeu::Buffer

  end # Buffers

  class Buffer

    repo Vedeu::Buffers.repository

  end # Buffer

end # Vedeu

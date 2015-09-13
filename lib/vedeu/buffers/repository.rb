module Vedeu

  module Buffers

    # Allows the storing of view buffers.
    #
    class Repository < Vedeu::Repository

      singleton_class.send(:alias_method, :buffers, :repository)

      null Vedeu::Buffers::Null
      real Vedeu::Buffers::Buffer

    end # Buffers

    class Buffer

      repo Vedeu::Buffers::Repository.repository

    end # Buffer

  end # Buffers

end # Vedeu

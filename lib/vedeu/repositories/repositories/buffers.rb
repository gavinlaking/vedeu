require 'vedeu/null/buffer'
require 'vedeu/buffers/buffer'

module Vedeu

  # Allows the storing of view buffers.
  #
  # @api public
  class Buffers < Repository

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

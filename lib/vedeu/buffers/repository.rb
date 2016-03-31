# frozen_string_literal: true

module Vedeu

  module Buffers

    # Allows the storing of view buffers.
    #
    # @api private
    #
    class Repository < Vedeu::Repositories::Repository

      null Vedeu::Buffers::Null
      real Vedeu::Buffers::Buffer

    end # Repository

    class Buffer

      repo Vedeu::Buffers::Repository.repository

    end # Buffer

  end # Buffers

  # Manipulate the repository of buffers.
  #
  # @example
  #   Vedeu.buffers
  #
  # @api public
  # @!method buffers
  # @return [Vedeu::Buffers::Repository]
  def_delegators Vedeu::Buffers::Repository,
                 :buffers

end # Vedeu

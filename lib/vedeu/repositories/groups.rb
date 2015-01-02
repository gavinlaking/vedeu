module Vedeu

  # Repository for storing and retrieving interfaces by their group name.
  #
  # @api private
  module Groups

    include Repository
    extend self

    private

    # @return [Hash]
    def in_memory
      {}
    end

  end # Groups

end # Vedeu

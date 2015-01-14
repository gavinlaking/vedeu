module Vedeu

  # When included into a class, provides the mechanism to store the class in a
  # repository for later retrieval.
  #
  # @api private
  module Model

    attr_reader :repository

    # @return [void] The model instance stored in the repository.
    def store
      repository.store(self) # if valid?
    end

  end # Model

end # Vedeu

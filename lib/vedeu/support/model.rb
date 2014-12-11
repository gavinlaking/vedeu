module Vedeu

  module Model

    attr_reader :repository

    # @return [void] The model instance stored in the repository.
    def store
      repository.store(self)
    end

  end # Model

end # Vedeu

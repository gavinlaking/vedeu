module Vedeu

  module Model

    # @return [void] The model instance stored in the repository.
    def store
      repository.store(self)
    end

  end # Model

end # Vedeu

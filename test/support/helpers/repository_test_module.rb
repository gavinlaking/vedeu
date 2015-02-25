module Vedeu

  module RepositoryTestModule

    extend self

    # The real repository stores the model and returns it.
    def store(model)
      model
    end

    private

    # A storage solution that uses memory to persist models.
    def in_memory
      {}
    end

  end # RepositoryTestModule

end # Vedeu

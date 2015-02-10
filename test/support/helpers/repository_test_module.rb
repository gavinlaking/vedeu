module Vedeu

  module RepositoryTestModule

    extend self

    # The real repository stores the model and returns it.
    def store(model)
      model
    end

    private

    def in_memory
      {}
    end

  end # RepositoryTestModule

end # Vedeu

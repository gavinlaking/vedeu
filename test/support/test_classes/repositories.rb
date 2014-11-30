module Vedeu

  class RepositoriesTestClass

    include Repository

    attr_accessor :storage
    alias_method :in_memory, :storage

    def initialize(storage = {})
      @storage = storage
    end

    def add(model)
      if storage.is_a?(Hash)
        @storage = in_memory.merge!(model)

      else
        @storage << model

      end
    end

  end # RepositoriesTestClass

end # Vedeu

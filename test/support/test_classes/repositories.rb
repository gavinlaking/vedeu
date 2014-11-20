module Vedeu

  class RepositoriesTestClass

    include Repository

    def initialize(storage = {})
      @storage = storage
    end

    def add(entity)
      if storage.is_a?(Hash)
        @storage = in_memory.merge!(entity)

      else
        @storage << entity

      end
    end

    attr_accessor :storage
    alias_method :in_memory, :storage

    def not_found(name)
      fail EntityNotFound
    end

  end # RepositoriesTestClass

end # Vedeu

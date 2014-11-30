module Vedeu

  module RepositoryTestModule

    include Repository
    extend self

    private

    def in_memory
      {}
    end

  end # RepositoryTestModule

end # Vedeu

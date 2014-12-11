module Vedeu

  class ModelTestClass

    include Vedeu::Model

    attr_reader :name

    def initialize(attributes = {})
      @attributes = attributes

      @name = @attributes[:name]
    end

    private

    def repository
      Vedeu::RepositoryTestModule
    end

  end # ModelTestClass

end # Vedeu

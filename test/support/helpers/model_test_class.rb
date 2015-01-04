module Vedeu

  class ModelTestClass

    extend  Vedeu::DSL
    include Vedeu::Model
    include Vedeu::Presentation

    attr_accessor :backgroud, :colour, :name, :style

    def initialize(attributes = {})
      @attributes = defaults.merge(attributes)

      @colour = @attributes[:colour]
      @name   = @attributes[:name]
      @style  = @attributes[:style]
    end

    def deputy
      Vedeu::DSL::ModelTestClass
    end

    private

    def defaults
      {
        colour: {},
        name:   '',
        style:  [],
      }
    end

    def repository
      Vedeu::RepositoryTestModule
    end

  end # ModelTestClass

end # Vedeu

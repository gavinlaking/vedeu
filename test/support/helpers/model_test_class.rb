module Vedeu

  class ModelTestClass

    include Vedeu::Model
    include Vedeu::Presentation

    attr_accessor :backgroud, :colour, :name, :style

    def initialize(attributes = {})
      @attributes = defaults.merge(attributes)

      @colour = @attributes[:colour]
      @name   = @attributes[:name]
      @style  = @attributes[:style]
      @repository = Vedeu::RepositoryTestModule
    end

    private

    def defaults
      {
        colour: {},
        name:   '',
        style:  [],
      }
    end

  end # ModelTestClass

end # Vedeu

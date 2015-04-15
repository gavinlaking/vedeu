require 'vedeu/repositories/model'
require 'vedeu/output/presentation'

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

  class ModelTestClass

    include Vedeu::Model
    include Vedeu::Presentation

    attr_accessor :background, :colour, :name, :style

    def initialize(attributes = {})
      @attributes = defaults.merge!(attributes)

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

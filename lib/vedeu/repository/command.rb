module Vedeu
  class Command
    attr_accessor :attributes, :name, :entity, :keyword, :keypress

    def initialize(attributes = {})
      @attributes = attributes || {}
      @name       = attributes[:name]
      @entity     = attributes[:entity]
      @keyword    = attributes.fetch(:options, {}).fetch(:keyword, '')
      @keypress   = attributes.fetch(:options, {}).fetch(:keypress, '')
    end

    def execute(args = [])
      executable.call(*args)
    end

    def executable
      proc { |*args| attributes[:entity].dispatch(*args) }
    end
  end
end

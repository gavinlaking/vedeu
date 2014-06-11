module Vedeu
  class Command
    attr_accessor :id, :attributes, :name, :klass, :keyword, :keypress

    class << self
      def create(attributes = {})
        new(attributes).create
      end
    end

    def initialize(attributes = {})
      @attributes = attributes || {}
      @name       = attributes[:name]
      @klass      = attributes[:klass]
      @keyword    = attributes.fetch(:options, {}).fetch(:keyword, "")
      @keypress   = attributes.fetch(:options, {}).fetch(:keypress, "")
    end

    def create
      CommandRepository.create(self)
      self
    end

    def execute(args = [])
      executable.call(*args)
    end

    def executable
      Proc.new { |*args| attributes[:klass].dispatch(*args) }
    end
  end
end

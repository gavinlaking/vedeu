module Vedeu
  class Command
    attr_accessor :id, :attributes

    class << self
      def create(attributes = {})
        new(attributes).create
      end
    end

    def initialize(attributes = {})
      @attributes = attributes
    end

    def create
      CommandRepository.create(self)
      self
    end

    def name
      attributes[:name]
    end

    def executable
      Proc.new { |*args| attributes[:klass].dispatch(*args) }
    end

    def options
      defaults.merge!(attributes)
    end

    def execute(args = [])
      executable.call(*args)
    end

    private

    def defaults
      {}
    end
  end
end

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

    def execute(args = [])
      executable.call(*args)
    end

    def name
      attributes[:name]
    end

    def executable
      Proc.new { |*args| attributes[:klass].dispatch(*args) }
    end

    def keyword
      options[:keyword]
    end

    def keypress
      options[:keypress]
    end

    def options
      defaults.merge!(attributes)
    end

    private

    def defaults
      {
        keyword:  "",
        keypress: ""
      }
    end
  end
end

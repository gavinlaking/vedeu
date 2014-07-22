module Vedeu
  class Builder
    def self.build(name, &block)
      new(name).build(&block)
    end

    def initialize(name)
      @name = name.to_s
    end

    def build(&block)
      self.instance_eval(&block)

      repository.create(attributes)
    end

    def repository
      raise StandardError, 'Subclasses implement this.'
    end

    private

    attr_reader :name

    def attributes
      user_attributes.merge!(overrides)
    end

    def overrides
      {}
    end

    def user_attributes
      @attributes ||= { name: name }
    end

    def method_missing(method_name, arg, &block)
      user_attributes[method_name] = arg
    end
  end
end

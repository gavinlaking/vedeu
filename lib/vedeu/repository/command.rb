module Vedeu
  class Command
    include Virtus.model

    attribute :name,      String
    attribute :entity,    Class
    attribute :keyword,   String, default: ''
    attribute :keypress,  String, default: ''
    attribute :arguments, Array,  default: []

    def execute(args = [])
      executable.call(*args)
    end

    def executable
      proc { |*args| entity.dispatch(*args) }
    end
  end
end

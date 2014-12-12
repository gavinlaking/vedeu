module Vedeu

  module DSL

    # Build models using a simple DSL when a block is given, otherwise returns a
    # new instance of the class including this module.
    #
    # @param attributes [Hash]
    # @param block [Proc]
    # @return [Class]
    def build(attributes = {}, &block)
      model = self.new(attributes)
      model.deputy.instance_eval(&block) if block_given?
      model
    end

  end # DSL

  class Node
    attr_accessor :name, :parent
    attr_reader :children

    def initialize(name)
      @name     = name
      @children = []
    end

    def add_child(node)
      @children << node

      node.parent = self
    end
    alias :<< :add_child

    def remove_child(node)
      @children.delete(node)
    end

    def [](index)
      @children[index]
    end

    def []=(index, node)
      replaced_child        = @children[index]
      @children[index]      = node
      replaced_child.parent = nil
      node.parent           = self
    end

    def leaf?
      children.empty?
    end
  end

  class Task < Node
    def initialize(name, time_required = nil)
      super(name)
      @time_required = time_required
    end
    def time_required
      if leaf?
        @time_required
      else
        time = 0.0
        children.each { |child_task| time += child_task.time_required }
        time
      end
    end
  end

end # Vedeu

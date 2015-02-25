module Vedeu

  # A composition class.
  #
  class Node

    attr_accessor :name,
      :parent

    attr_reader   :children

    # @return [void]
    def initialize(name)
      @name     = name
      @children = []
    end

    # @return [void]
    def add_child(node)
      children << node

      node.parent = self
    end
    alias :<< :add_child

    # @return [void]
    def remove_child(node)
      children.delete(node)
    end

    # @return [void]
    def [](index)
      children[index]
    end

    # @return [void]
    def []=(index, node)
      replaced_child        = @children[index]
      children[index]       = node
      replaced_child.parent = nil
      node.parent           = self
    end

    # @return [void]
    def leaf?
      children.empty?
    end

  end # Node

end # Vedeu

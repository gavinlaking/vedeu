module Vedeu

  # A composition class.
  #
  class Node

    attr_accessor :name,
      :parent

    attr_reader   :children

    # @return []
    def initialize(name)
      @name     = name
      @children = []
    end

    # @return []
    def add_child(node)
      children << node

      node.parent = self
    end
    alias :<< :add_child

    # @return []
    def remove_child(node)
      children.delete(node)
    end

    # @return []
    def [](index)
      children[index]
    end

    # @return []
    def []=(index, node)
      replaced_child        = @children[index]
      children[index]       = node
      replaced_child.parent = nil
      node.parent           = self
    end

    # @return []
    def leaf?
      children.empty?
    end

  end # Node

end # Vedeu

module Vedeu
  class Groups

    # @return [Groups]
    def initialize; end

    # @return [Set]
    def all
      @_storage
    end

    # @param name [String]
    # @return [Set]
    def find(name)
      storage.fetch(name) do
        fail GroupNotFound, 'Cannot find interface group with this name.'
      end
    end

    # @param group [String]
    # @param name [String]
    # @param delay [Float]
    # @return [Groups|FalseClass]
    def add(group, name, delay = 0.0)
      return false if group.empty?

      storage[group] << name

      register_group_refresh_event(group, delay)

      self
    end

    # @return [Hash]
    def reset
      @_storage = in_memory
    end

    private

    def register_group_refresh_event(group, delay = 0.0)
      Vedeu.event("_refresh_group_#{group}_".to_sym, { delay: delay }) do
        Buffers.refresh_group(group)
      end
    end

    # @return [Hash]
    def storage
      @_storage ||= in_memory
    end

    # @return [Hash]
    def in_memory
      Hash.new { |hash, key| hash[key] = Set.new }
    end
  end
end

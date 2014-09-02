module Vedeu
  class Groups

    # @return [Groups]
    def initialize; end

    # @return [Set]
    def all
      @_storage
    end

    # @param group_name [String]
    # @return [Set]
    def find(name)
      storage.fetch(name) do
        fail GroupNotFound,
          "Cannot find interface group with this name: #{name.to_s}."
      end
    end

    # @param group_name     [String]
    # @param interface_name [String]
    # @param delay          [Float]
    # @return [Groups|FalseClass]
    def add(group_name, interface_name, delay = 0.0)
      return false if group_name.empty?

      storage[group_name] << interface_name

      register_group_refresh_event(group_name, delay)

      self
    end

    def registered
      storage.keys
    end

    # @return [Hash]
    def reset
      @_storage = in_memory
    end

    private

    # @api private
    # @return []
    def register_group_refresh_event(group, delay = 0.0)
      Vedeu.event("_refresh_group_#{group}_".to_sym, { delay: delay }) do
        Buffers.refresh_group(group)
      end
    end

    # @api private
    # @return [Hash]
    def storage
      @_storage ||= in_memory
    end

    # @api private
    # @return [Hash]
    def in_memory
      Hash.new { |hash, key| hash[key] = Set.new }
    end
  end
end

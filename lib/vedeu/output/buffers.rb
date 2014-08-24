module Vedeu
  module Buffers

    extend self

    # @param interface [Interface]
    # @return []
    def create(interface)
      store(interface.name, Buffer.new({
                              back:      nil,
                              front:     nil,
                              interface: interface }))

      groups[interface.group] << interface.name unless interface.group.empty?

      create_events(interface)
    end

    # @param name [String]
    # @param view [Interface]
    # @return []
    def enqueue(name, view)
      store(name, query(name).enqueue(view))
    end

    # @return [Array]
    def refresh_all
      buffers.keys.map { |name| refresh(name) }
    end

    # @return [Hash]
    def reset
      @_buffers = {}
    end

    private

    def create_events(interface)
      delay = interface.delay
      group = interface.group
      name  = interface.name
      refresh_name  = "_refresh_#{name}_".to_sym
      refresh_group = "_refresh_group_#{group}_".to_sym

      Vedeu.event(refresh_name, delay) { refresh(name) }

      unless group.empty?
        Vedeu.event(refresh_group, delay) { refresh_group(group) }
      end
    end

    def query(name)
      buffers.fetch(name) {
        fail RefreshFailed, 'Cannot refresh non-existent interface.'
      }
    end

    def query_groups(group_name)
      groups.fetch(group_name) {
        fail GroupNotFound, 'Cannot find interface group with this name.'
      }
    end

    def refresh(name)
      store(name, query(name).refresh)
    end

    def refresh_group(group_name)
      query_groups(group_name).map { |name| refresh(name) }
    end

    def store(name, buffer)
      buffers.store(name, buffer)
    end

    def groups
      @_groups ||= Hash.new { |hash, key| hash[key] = [] }
    end

    def buffers
      @_buffers ||= {}
    end

  end
end

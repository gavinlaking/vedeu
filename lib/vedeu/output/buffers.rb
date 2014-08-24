module Vedeu
  module Buffers

    extend self

    # @param []
    # @return []
    def create(interface)
      store(interface.name, Buffer.new({
                              interface: interface,
                              name:      interface.name,
                              current:   nil,
                              group:     interface.group,
                              next:      nil
                            }))

      create_events(interface.name, interface.group, interface.delay)
    end

    # @param []
    # @param []
    # @return []
    def enqueue(name, sequence)
      store(name, query(name).enqueue(sequence))
    end

    # @return [Array]
    def refresh_all
      buffers.keys.map { |name| refresh(name) }
    end

    # @return [Hash]
    def reset
      @buffers = {}
    end

    private

    def create_events(name, group, delay)
      Vedeu.event("_refresh_#{name}_".to_sym, delay) { refresh(name) }

      Vedeu.event("_refresh_group_#{group}_".to_sym, delay) do
        refresh_group(group)
      end unless group.nil? || group.empty?
    end

    def query(name)
      buffers.fetch(name) {
        fail RefreshFailed, 'Cannot refresh non-existent interface.'
      }
    end

    def refresh(name)
      store(name, query(name).refresh)
    end

    def refresh_group(group)
      buffers.select.map do |name, buffer|
        name if buffer.group == group
      end.compact.map { |name| refresh(name) }
    end

    def store(name, buffer)
      buffers.store(name, buffer)
    end

    def buffers
      @buffers ||= {}
    end

  end
end

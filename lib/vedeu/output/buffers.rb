module Vedeu
  RefreshFailed = Class.new(StandardError)

  module Buffers
    extend self

    def create(interface)
      buffers[interface.name][:clear] = Clear.call(interface)

      Vedeu.events.event("_refresh_#{interface.name}_".to_sym, interface.delay) do
        refresh(interface.name)
      end

      # TODO: cannot refresh group since no logic to fetch group from buffer
      # unless interface.group.nil? || interface.group.empty?
      #   Vedeu.events.event("_refresh_#{interface.group}_".to_sym, interface.delay) do
      #     refresh_group(interface.group)
      #   end
      # end
    end

    def enqueue(name, sequence)
      buffers[name][:next].unshift(sequence)
    end

    def query(name)
      buffers.fetch(name) do
        fail RefreshFailed, 'Cannot refresh non-existent interface.'
      end
    end

    def refresh(name)
      data = query(name)

      sequence = if data[:next].any?
        data[:current] = data[:next].pop

      elsif data[:current].empty?
        data[:clear]

      else
        data[:current]

      end
      Terminal.output(sequence)
    end

    def refresh_all
      buffers.keys.map { |name| refresh(name) }
    end

    def reset
      @buffers = {}
    end

    private

    def buffers
      @buffers ||= Hash.new do |hash, key|
        hash[key] = { current: '', next: [], clear: '' }
      end
    end
  end
end

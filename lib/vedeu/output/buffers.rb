module Vedeu
  RefreshFailed = Class.new(StandardError)

  module Buffers
    extend self

    def create(name, sequence)
      buffers[name][:clear] = sequence
    end

    def enqueue(name, sequence)
      buffers[name][:next].unshift(sequence)
    end

    def refresh(name)
      data = buffers.fetch(name) do
        fail RefreshFailed, 'Cannot refresh non-existent interface.'
      end

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

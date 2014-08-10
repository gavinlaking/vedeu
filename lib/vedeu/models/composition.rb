require 'pry'
require 'virtus'

require 'vedeu/support/terminal'
require 'vedeu/models/attributes/interface_collection'

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
      buffers.keys.map do |name|
        refresh(name)
      end
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

  class Composition
    include Virtus.model

    attribute :interfaces, InterfaceCollection

    def self.enqueue(attributes)
      new(attributes).enqueue
    end

    def enqueue
      interfaces.map do |interface|
        Buffers.enqueue(interface.name, interface.to_s)
      end
    end

    def to_s
      interfaces.map(&:to_s).join
    end
  end
end

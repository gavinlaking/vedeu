module Vedeu
  class Buffer
    attr_reader :clear, :current, :group, :name, :_next

    def initialize(vars)
      @vars    = vars
      @name    = vars.fetch(:name)
      @clear   = vars.fetch(:clear)
      @current = vars.fetch(:current)
      @group   = vars.fetch(:group)
      @_next   = vars.fetch(:next)
    end

    def enqueue(sequence)
      merge({ next: sequence })
    end

    def merge(vars)
      Buffer.new(@vars.merge(vars))
    end

    def refresh
      sequence = if !_next.empty?
        merge({ current: _next, next: '' }).current

      elsif current.empty?
        clear

      else
        current

      end

      Terminal.output(sequence)

      self
    end
  end
end

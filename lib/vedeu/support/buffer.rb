module Vedeu
  class Buffer
    attr_reader :current, :group, :interface, :name, :_next

    def initialize(vars)
      @vars    = vars
      @name    = vars.fetch(:name)
      @group   = vars.fetch(:group)
      @current = vars.fetch(:current)

      @interface = vars.fetch(:interface)
      @_next   = vars.fetch(:next)
    end

    def enqueue(sequence)
      merge({ next: sequence })
    end

    def refresh
      sequence = if _next
        merge({ current: _next, next: nil }).current.to_s

      elsif current.nil?
        interface.clear

      else
        current.to_s

      end

      Terminal.output(sequence)

      self
    end

    private

    def merge(vars)
      Buffer.new(@vars.merge(vars))
    end
  end
end

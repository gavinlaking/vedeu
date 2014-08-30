module Vedeu

  # Maintains which interface is current in focus.
  class Focus

    # @return [Focus]
    def initialize
      register_events

      self
    end

    # @param name [String]
    # @return [Array]
    def add(name)
      if registered?(name)
        storage

      else
        storage << name

      end
    end

    # @param name [String]
    # @return [String]
    def by_name(name)
      fail InterfaceNotFound unless storage.include?(name)

      storage.rotate!(storage.index(name))

      current
    end

    # @return [String]
    def current
      fail NoInterfacesDefined if storage.empty?

      storage.first
    end

    # @return [String]
    def next_item
      storage.rotate!

      current
    end

    # @return [String]
    def prev_item
      storage.rotate!(-1)

      current
    end

    # @return [TrueClass]
    def register_events
      Vedeu.event(:_focus_next_)    { next_item }
      Vedeu.event(:_focus_prev_)    { prev_item }
      Vedeu.event(:_focus_by_name_) { |name| by_name(name) }
      Vedeu.event(:_focussed_)      { current }

      true
    end

    private

    # @api private
    # @return [TrueClass|FalseClass]
    def registered?(name)
      return false if storage.empty?

      storage.include?(name)
    end

    # @api private
    # @return [Array]
    def storage
      @storage ||= []
    end

  end
end

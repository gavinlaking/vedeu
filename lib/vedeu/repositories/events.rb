module Vedeu

  # Provides a mechanism for storing and retrieving events by name. A single
  # name can contain many events. Also, an event can trigger other events.
  module Events

    include Repository
    extend self

    # @see Vedeu::API#event
    def add(name, opts = {}, &block)
      Vedeu.log("Registering event: '#{name}'")

      options = opts.merge!({ event_name: name })

      storage[name][:events] << Event.new(block, options)
      storage[name]
    end
    alias_method :event, :add

    # @see Vedeu::API#unevent
    def remove(name)
      return false unless registered?(name)

      storage.delete(name) { false }

      true
    end
    alias_method :unevent, :remove

    # @see Vedeu::API#trigger
    def use(name, *args)
      results = storage[name][:events].map { |event| event.trigger(*args) }

      if results.one?
        results.first

      else
        results

      end
    end
    alias_method :trigger, :use

    private

    # Returns an empty collection ready for the storing of events by name with
    # associated event instance.
    #
    # @return [Hash]
    def in_memory
      Hash.new { |hash, key| hash[key] = { events: [] } }
    end

    # System events needed by Vedeu to run.
    add(:_clear_)                   { Terminal.clear_screen     }
    add(:_exit_)                    { Vedeu::Application.stop   }
    add(:_keypress_)                { |key| Vedeu.keypress(key) }
    add(:_log_)                     { |msg| Vedeu.log(msg)      }
    add(:_mode_switch_)             { fail ModeSwitch           }
    add(:_resize_, { delay: 0.25 }) { Vedeu.resize              }

  end # Events

end # Vedeu

module Vedeu

  # Provides a mechanism for storing and retrieving events by name. A single
  # name can contain many events. Also, an event can trigger other events.
  #
  # @todo I really don't like the 'hashiness' of this. (GL 2014-10-29)
  #
  # @api private
  module Events

    include Repository
    extend self

    # @see Vedeu::API#unevent
    alias_method :unevent, :remove

    # @see Vedeu::API#event
    def add(name, options = {}, &block)
      Vedeu.log("Registering event: '#{name}'")

      events(name) << Event.new(name, options, block)
    end
    alias_method :event, :add

    # @see Vedeu::API#trigger
    def use(name, *args)
      results = events(name).map { |event| event.trigger(*args) }

      return results.first if results.one?

      results
    end
    alias_method :trigger, :use

    private

    def events(name)
      storage[name][:events]
    end

    # Returns an empty collection ready for the storing of events by name with
    # associated event instance.
    #
    # @return [Hash]
    def in_memory
      Hash.new { |hash, key| hash[key] = { events: [] } }
    end

    # System events needed by Vedeu to run.
    event(:_clear_)                   { Terminal.clear_screen     }
    event(:_exit_)                    { Vedeu::Application.stop   }
    event(:_initialize_)              { Vedeu.trigger(:_refresh_) }
    event(:_keypress_)                { |key| Vedeu.keypress(key) }
    event(:_log_)                     { |msg| Vedeu.log(msg)      }
    event(:_mode_switch_)             { fail ModeSwitch           }
    event(:_resize_, { delay: 0.25 }) { Vedeu.resize              }

  end # Events

end # Vedeu

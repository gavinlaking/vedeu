module Vedeu
  module API
    # @param name  [Symbol] The name of the event which will be triggered later
    # @param delay [Fixnum|Float] Limits the execution of the triggered event to
    #   the delay in seconds, effectively throttling the event. A delay of 1.0
    #   will mean that even if the event is triggered multiple times a second
    #   it will only execute once for that second. Triggers inside the delay are
    #   discarded.
    # @param block [Proc] The event to be executed when triggered. This block
    #   could be a method call, or the triggering of another event, or sequence
    #   of either/both.
    def event(name, delay = 0, &block)
      Vedeu.events.event(name, delay, &block)
    end

    # @api private
    def events
      @events ||= API::Events.new do
        event(:_log_)         { |msg| Vedeu.log(msg)      }
        event(:_exit_)        { Vedeu.shutdown            }
        event(:_mode_switch_) { fail ModeSwitch           }
        event(:_clear_)       { Terminal.clear_screen     }
        event(:_refresh_)     { Buffers.refresh_all       }
        event(:_keypress_)    { |key| Vedeu.keypress(key) }
      end
    end

    # @api private
    def shutdown
      trigger(:_cleanup_)

      fail StopIteration
    end

    # @return [Fixnum] The total height of the current terminal.
    def height
      Terminal.height
    end

    # @param name  [String] The name of the interface. Used to reference the
    #   interface throughout your application's execution lifetime.
    # @param block [Proc] A set of attributes which define the features of the
    #   interface. TODO: More help.
    def interface(name, &block)
      API::Interface.define({ name: name }, &block)
    end

    # @param key [String] A simulated keypress. Escape sequences are also
    #   supported.
    def keypress(key)
      trigger(:key, key)
      trigger(:_log_, "Key: #{key}")
      trigger(:_mode_switch_) if key == :escape
    end

    # @param message [String] The message you wish to emit to the log
    #   file, useful for debugging.
    def log(message)
      API::Log.logger.debug(message)
    end

    # @param name [Symbol] The name of the event you wish to trigger.
    #   The event does not have to exist.
    # @param args [Array] Any arguments the event needs to execute correctly.
    def trigger(name, *args)
      Vedeu.events.trigger(name, *args)
    end

    # @param name [String] The name of the interface you wish to use. Typically
    #   used when defining interfaces to share geometry. TODO: Example required.
    def use(name)
      Vedeu::Interface.new(Vedeu::Store.query(name))
    end

    # @param name [String] The name of the interface you are targetting for this
    #   view.
    # @param block [Proc] The directives you wish to send to this interface.
    #   TODO: Example required.
    def view(name, &block)
      {
        interfaces: [
          API::Interface.build({ name: name }, &block)
        ]
      }
    end

    # @param block [Proc] Instructs Vedeu to treat all of the 'view' directives
    #   therein as one instruction. Useful for redrawing multiple interfaces at
    #   once. TODO: Example required.
    def views(&block)
      API::Composition.build(&block)
    end

    # @return [Fixnum] The total width of the current terminal.
    def width
      Terminal.width
    end
  end

  extend API
end

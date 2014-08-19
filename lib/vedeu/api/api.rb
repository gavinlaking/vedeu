module Vedeu
  module API
    def event(name, delay = 0, &block)
      Vedeu.events.event(name, delay, &block)
    end

    def events
      @events ||= API::Events.new do
        event(:_log_)         { |msg| Vedeu.log(msg)      }
        event(:_exit_)        { fail StopIteration        }
        event(:_mode_switch_) { fail ModeSwitch           }
        event(:_clear_)       { Terminal.clear_screen     }
        event(:_refresh_)     { Buffers.refresh_all       }
        event(:_keypress_)    { |key| Vedeu.keypress(key) }
      end
    end

    def height
      Terminal.height
    end

    def interface(name, &block)
      API::Interface.define({ name: name }, &block)
    end

    def keypress(key)
      trigger(:key, key)
      trigger(:_log_, "Key: #{key}")
      trigger(:_mode_switch_) if key == :escape
    end

    def log(message)
      API::Log.logger.debug(message)
    end

    def trigger(name, *args)
      Vedeu.events.trigger(name, *args)
    end

    def use(name)
      Vedeu::Interface.new(Vedeu::Store.query(name))
    end

    def view(name, &block)
      {
        interfaces: [
          API::Interface.build({ name: name }, &block)
        ]
      }
    end

    def views(&block)
      API::Composition.build(&block)
    end

    def width
      Terminal.width
    end
  end

  extend API
end

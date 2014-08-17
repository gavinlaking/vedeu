module Vedeu
  module API
    def event(name, delay = 0, &block)
      Vedeu.events.event(name, delay, &block)
    end

    def events
      @events ||= API::Events.new do
        event(:_exit_)        { fail StopIteration                   }
        event(:_log_)         { |message| Vedeu.log(message)         }
        event(:_mode_switch_) { fail ModeSwitch                      }
        event(:_clear_)       { Terminal.output(Esc.string('clear')) }
        event(:_refresh_)     { Buffers.refresh_all                  }

        event(:_keypress_) do |key|
          trigger(:key, key)
          trigger(:_log_, (' ' * 42) + "key: #{key}")
          trigger(:_mode_switch_) if key == :escape
        end
      end
    end

    def height
      Terminal.height
    end

    def interface(name, &block)
      API::Interface.define({ name: name }, &block)
    end

    def log(message)
      API::Log.logger.debug(message)
    end

    # def render(object = nil)
    #   Vedeu::View.render(object)
    # end

    def trigger(name, *args)
      Vedeu.events.trigger(name, *args)
    end

    def use(name)
      Vedeu::Interface.new(Vedeu::Store.query(name))
    end

    def view(name, &block)
      API::Interface.build({ name: name }, &block)
    end

    def width
      Terminal.width
    end
  end

  extend API
end

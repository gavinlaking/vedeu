module Vedeu

  # Provides the API to Vedeu. Methods therein, and classes belonging to this
  # module expose Vedeu's core functionality.
  module API

    # Returns information about various registered subsystems when used with
    # a defined method within {Vedeu::API::Defined}.
    #
    # @api public
    # @see Vedeu::API::Defined
    # @return [Vedeu::API::Defined]
    def defined
      Vedeu::API::Defined
    end

    # Register an event by name with optional delay (throttling) which when
    # triggered will execute the code contained within the passed block.
    #
    # @api public
    # @param name  [Symbol] The name of the event which will be triggered later.
    # @param [Hash] opts The options to register the event with.
    # @option opts :delay [Fixnum|Float] Limits the execution of the
    #   triggered event to only execute when first triggered, with subsequent
    #   triggering being ignored until the delay has expired.
    # @option opts :debounce [Fixnum|Float] Limits the execution of the
    #   triggered event to only execute once the debounce has expired.
    #   Subsequent triggers before debounce expiry are ignored.
    # @param block [Proc] The event to be executed when triggered. This block
    #   could be a method call, or the triggering of another event, or sequence
    #   of either/both.
    #
    # @example
    #   Vedeu.event :my_event do |some, args|
    #     ... some code here ...
    #
    #     Vedeu.trigger(:my_other_event)
    #   end
    #
    #   T = Triggered, X = Executed, i = Ignored.
    #
    #   0.0.....0.2.....0.4.....0.6.....0.8.....1.0.....1.2.....1.4.....1.6...
    #   .T...T...T...T...T...T...T...T...T...T...T...T...T...T...T...T...T...T
    #   .X...i...i...i...i...X...i...i...i...i...X...i...i...i...i...i...i...i
    #
    #   Vedeu.event(:my_delayed_event, { delay: 0.5 })
    #     ... some code here ...
    #   end
    #
    #   T = Triggered, X = Executed, i = Ignored.
    #
    #   0.0.....0.2.....0.4.....0.6.....0.8.....1.0.....1.2.....1.4.....1.6...
    #   .T...T...T...T...T...T...T...T...T...T...T...T...T...T...T...T...T...T
    #   .i...i...i...i...i...i...i...X...i...i...i...i...i...i...X...i...i...i
    #
    #   Vedeu.event(:my_debounced_event, { debounce: 0.7 })
    #     ... some code here ...
    #   end
    #
    # @return [Hash]
    def event(name, opts = {}, &block)
      Vedeu.events.event(name, opts = {}, &block)
    end

    # Unregisters the event by name, effectively deleting the associated events
    # bound with it also.
    #
    # @api public
    # @param name [Symbol]
    # @return [Hash]
    def unevent(name)
      Vedeu.events.unevent(name)
    end

    # Find out how many lines the current terminal is able to display.
    #
    # @api public
    # @example
    #   Vedeu.height
    #
    # @return [Fixnum] The total height of the current terminal.
    def height
      Terminal.height
    end

    # Register an interface by name which will display output from a event or
    # command. This provides the means for you to define your application's
    # views without their content.
    #
    # @api public
    # @param name  [String] The name of the interface. Used to reference the
    #   interface throughout your application's execution lifetime.
    # @param block [Proc] A set of attributes which define the features of the
    #   interface. TODO: More help.
    #
    # @example
    #   Vedeu.interface 'my_interface' do
    #     ...
    #
    #   Vedeu.interface do
    #     name 'interfaces_must_have_a_name'
    #     ...
    #
    # @return [TrueClass]
    def interface(name = '', &block)
      API::Interface.define({ name: name }, &block)
    end

    # Handles the keypress in your application. Can also be used to simulate a
    # keypress. The example below will have the following workflow:
    #
    # 1) Trigger the event `:key` in your application, which you will handle
    #    and perform the appropriate action- maybe nothing.
    # 2) If debugging is enabled in Vedeu, then the key is logged to the log
    #    file.
    #
    # @api public
    # @param key [String|Symbol] The key which was pressed. Escape sequences
    #   are also supported. Special keys like the F-keys are named as symbols;
    #   i.e. `:f4`. A list of these translations can be found at {Vedeu::Input}.
    #
    # @example
    #   Vedeu.keypress('s')
    #
    # @return []
    def keypress(key)
      Vedeu.trigger(:key, key)
      Vedeu.trigger(:_log_, "Key: #{key}") if Configuration.debug?
      Vedeu.trigger(:_mode_switch_) if key == :escape
      Vedeu.trigger(:_focus_next_)  if key == :tab
      Vedeu.trigger(:_focus_prev_)  if key == :shift_tab
    end

    # Write a message to the Vedeu log file located at `$HOME/.vedeu/vedeu.log`
    #
    # @api public
    # @param message [String] The message you wish to emit to the log
    #   file, useful for debugging.
    # @param force   [TrueClass|FalseClass] When evaluates to true will
    #   write to the log file regardless of the Configuration setting.
    #
    # @example
    #   Vedeu.log('A useful debugging message: Error!')
    #
    # @return [TrueClass]
    def log(message, force = false)
      Vedeu::Log.logger.debug(message) if Configuration.debug? || force
    end

    # Trigger a registered or system event by name with arguments.
    #
    # @api public
    # @param name [Symbol] The name of the event you wish to trigger.
    #   The event does not have to exist.
    # @param args [Array] Any arguments the event needs to execute correctly.
    #
    # @example
    #   Vedeu.trigger(:my_event, :oxidize, 'nitrogen')
    #
    # @return [Array]
    def trigger(name, *args)
      Vedeu.events.trigger(name, *args)
    end

    # Use attributes of another interface whilst defining one. TODO: More help.
    #
    # @api public
    # @param name [String] The name of the interface you wish to use. Typically
    #   used when defining interfaces to share geometry.
    #
    # @example
    #   Vedeu.interface 'main_screen' do
    #     width use('my_interface').width
    #     x     use('my_interface').east(1)
    #     ...
    #
    # @return [Vedeu::Interface]
    def use(name)
      Vedeu::Interface.new(Vedeu::Interfaces.find(name))
    end

    # Define a view (content) for an interface. TODO: More help.
    #
    # @api public
    # @param name [String] The name of the interface you are targetting for this
    #   view.
    # @param block [Proc] The directives you wish to send to this interface.
    #
    # @example
    #   view 'my_interface' do
    #     ...
    #
    # @return [Hash]
    def view(name, &block)
      API::Composition.build { view(name, &block) }
    end

    # Instruct Vedeu to treat contents of block as a single composition.
    #
    # @api public
    # @param block [Proc] Instructs Vedeu to treat all of the 'view' directives
    #   therein as one instruction. Useful for redrawing multiple interfaces at
    #   once.
    #
    # @example
    #   views do
    #     view 'my_interface' do
    #       ... some attributes ...
    #     end
    #     view 'my_other_interface' do
    #       ... some other attributes ...
    #     end
    #     ...
    #
    #   composition do
    #     view 'my_interface' do
    #       ...
    #   ...
    #
    # @return [Hash]
    def views(&block)
      fail InvalidSyntax, '`views` requires a block.' unless block_given?

      API::Composition.build(&block)
    end
    alias_method :composition, :views

    # Find out how many columns the current terminal is able to display.
    #
    # @api public
    # @example
    #   Vedeu.width
    #
    # @return [Fixnum] The total width of the current terminal.
    def width
      Terminal.width
    end

    # Initially accessed by Vedeu itself, this sets up some basic events needed
    # by Vedeu to run. Afterwards, it is simply a gateway to the Events class
    # used by other API methods.
    #
    # @api private
    # @return [Events]
    def events
      @events ||= Vedeu::Events.new do
        event(:_clear_)                   { Terminal.clear_screen     }
        event(:_exit_)                    { Vedeu::Application.stop   }
        event(:_focus_by_name_)           { |name| Vedeu::Focus.by_name(name) }
        event(:_focus_next_)              { Vedeu::Focus.next_item    }
        event(:_focus_prev_)              { Vedeu::Focus.prev_item    }
        event(:_keypress_)                { |key| Vedeu.keypress(key) }
        event(:_log_)                     { |msg| Vedeu.log(msg)      }
        event(:_mode_switch_)             { fail ModeSwitch           }
        event(:_refresh_)                 { Vedeu::Refresh.all        }
        event(:_resize_, { delay: 0.25 }) { Vedeu.resize              }
      end
    end

    # When the terminal emit the 'SIGWINCH' signal, Vedeu can intercept this
    # and attempt to redraw the current interface with varying degrees of
    # success. Can also be used to simulate a terminal resize.
    #
    # @api private
    # @return []
    # :nocov:
    def resize
      trigger(:_clear_)

      trigger(:_refresh_)
    end
    # :nocov:

  end

  extend API

  trap('SIGWINCH') { Vedeu.trigger(:_resize_) }
end

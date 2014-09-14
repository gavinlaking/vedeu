module Vedeu

  # Vedeu::Trace.call({ trace: true })

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
      Vedeu.events.event(name, opts, &block)
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

    # @api public
    #
    # @example
    #   Vedeu.keypress('s')
    #
    # @see Vedeu::Keymaps.use
    def keypress(key)
      Vedeu::Keymaps.use(key)
    end

    # Define actions for keypresses for when specific interfaces are in focus.
    # Unless an interface is specified, the key will be assumed to be global,
    # meaning its action will happen regardless of the interface in focus.
    #
    # @api public
    # @param name_or_names [String] The name or names of the interface(s) which
    #   will handle these keys.
    # @param block [Proc]
    #
    # @example
    #   keys do                    # => will be global
    #     key('s') { :something }
    #     ...
    #
    #   keys 'my_interface' do     # => will only function when 'my_interface'
    #     ...                      #    is in focus
    #
    #   keys('main', 'other') do   # => will function for both 'main' and
    #     ...                      #    'other' interfaces
    #
    #   keys do
    #     interface 'my_interface' # => will only function when 'my_interface'
    #     ...                      #    is in focus
    #
    # @return [API::Keymap]
    def keys(*name_or_names, &block)
      fail InvalidSyntax, '`keys` requires a block.' unless block_given?

      API::Keymap.define({ interfaces: name_or_names }, &block)
    end

    # Write a message to the Vedeu log file located at `$HOME/.vedeu/vedeu.log`
    #
    # @api public
    # @param message [String] The message you wish to emit to the log
    #   file, useful for debugging.
    # @param force   [Boolean] When evaluates to true will
    #   write to the log file regardless of the Configuration setting.
    #
    # @example
    #   Vedeu.log('A useful debugging message: Error!')
    #
    # @return [TrueClass]
    def log(message, force = false)
      Vedeu::Log.logger.debug(message) if Configuration.debug? || force
    end

    # Register a menu by name which will display a collection of items for your
    # users to select; and provide interactivity within your application.
    #
    # @api public
    # @param name  [String] The name of the menu. Used to reference the
    #   menu throughout your application's execution lifetime.
    # @param block [Proc] A set of attributes which define the features of the
    #   menu. See {Vedeu::API::Menu#items} and {Vedeu::API::Menu#name}.
    #
    # @example
    #   Vedeu.menu 'my_interface' do
    #     items [:item_1, :item_2, :item_3]
    #     ...
    #
    #   Vedeu.menu do
    #     name 'menus_must_have_a_name'
    #     items Track.all_my_favourites
    #     ...
    #
    # @return [API::Menu]
    def menu(name = '', &block)
      fail InvalidSyntax, '`menu` requires a block.' unless block_given?

      API::Menu.define({ name: name }, &block)
    end

    # Directly write a view buffer to the terminal. Using this method means
    # that the refresh event does not need to be triggered after creating the
    # view or views, though can be later triggered if needed.
    #
    # @api public
    # @param block [Proc] The directives you wish to send to render. Must
    #                     include `view` or `views` with associated sub-
    #                     directives.
    #
    # @example
    #   Vedeu.render do
    #     views do
    #       view 'my_interface' do
    #         ...
    #
    # @return [Array]
    def render(&block)
      API::Composition.render(&block)
    end

    # When the terminal emit the 'SIGWINCH' signal, Vedeu can intercept this
    # and attempt to redraw the current interface with varying degrees of
    # success. Can also be used to simulate a terminal resize.
    #
    # @api private
    # @return [TrueClass]
    # :nocov:
    def resize
      trigger(:_clear_)

      trigger(:_refresh_)

      true
    end
    # :nocov:

    # Trigger a registered or system event by name with arguments. If the
    # event stored returns a value, that is returned.
    #
    # @api public
    # @param name [Symbol] The name of the event you wish to trigger.
    #   The event does not have to exist.
    # @param args [Array] Any arguments the event needs to execute correctly.
    #
    # @example
    #   Vedeu.trigger(:my_event, :oxidize, 'nitrogen')
    #
    # @return [Array|undefined]
    def trigger(name, *args)
      Vedeu.events.trigger(name, *args)
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

  end

  extend API

  trap('SIGWINCH') { Vedeu.trigger(:_resize_) }
end

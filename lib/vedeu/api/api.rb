module Vedeu

  # Vedeu::Trace.call({ trace: true })

  # Provides the API to Vedeu. Methods therein, and classes belonging to this
  # module expose Vedeu's core functionality.
  #
  # @api public
  module API

    # Configure Vedeu using a simple configuration DSL.
    #
    # @param block [Proc]
    # @raise [InvalidSyntax] When the required block is not given.
    # @return [Hash]
    # @see Vedeu::Configuration
    def configure(&block)
      fail InvalidSyntax, '`configure` requires a block.' unless block_given?

      Vedeu::Configuration.configure(&block)
    end

    # Returns information about various registered subsystems when used with
    # a defined method within {Vedeu::API::Defined}.
    #
    # @return [Vedeu::API::Defined]
    # @see Vedeu::API::Defined
    def defined
      Vedeu::API::Defined
    end

    # Register an event by name with optional delay (throttling) which when
    # triggered will execute the code contained within the passed block.
    #
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
      Events.add(name, opts, &block)
    end

    # Used after defining an interface or interfaces to set the initially
    # focussed interface.
    #
    # @param name [String] The interface to focus; must be defined.
    # @return [String] The name of the interface now in focus.
    # @raise [InterfaceNotFound] When the interface cannot be found.
    def focus(name)
      Vedeu.trigger(:_focus_by_name_, name)
    end

    # Find out how many lines the current terminal is able to display.
    #
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
    # @todo More documentation required.
    # @param name  [String] The name of the interface. Used to reference the
    #   interface throughout your application's execution lifetime.
    # @param block [Proc] A set of attributes which define the features of the
    #   interface.
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

    # Simulate a keypress.
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
    # @raise [InvalidSyntax] When the required block is not given.
    # @return [API::Keymap]
    def keys(*name_or_names, &block)
      fail InvalidSyntax, '`keys` requires a block.' unless block_given?

      API::Keymap.define({ interfaces: name_or_names }, &block)
    end

    # Write a message to the Vedeu log file located at `$HOME/.vedeu/vedeu.log`
    #
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
    # @raise [InvalidSyntax] When the required block is not given.
    # @return [API::Menu]
    def menu(name = '', &block)
      fail InvalidSyntax, '`menu` requires a block.' unless block_given?

      API::Menu.define({ name: name }, &block)
    end

    # Directly write a view buffer to the terminal. Using this method means
    # that the refresh event does not need to be triggered after creating the
    # view or views, though can be later triggered if needed.
    #
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

      trigger(:_cursor_refresh_)

      true
    end
    # :nocov:

    # Trigger a registered or system event by name with arguments. If the
    # event stored returns a value, that is returned.
    #
    # @param name [Symbol] The name of the event you wish to trigger.
    #   The event does not have to exist.
    # @param args [Array] Any arguments the event needs to execute correctly.
    #
    # @example
    #   Vedeu.trigger(:my_event, :oxidize, 'nitrogen')
    #
    # @return [Array|undefined]
    def trigger(name, *args)
      Events.use(name, *args)
    end

    # Unregisters the event by name, effectively deleting the associated events
    # bound with it also.
    #
    # @param name [Symbol]
    # @return [Hash]
    def unevent(name)
      Events.remove(name)
    end

    # Use attributes of another interface whilst defining one.
    #
    # @todo More documentation required.
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

    # Define a view (content) for an interface.
    #
    # @todo More documentation required.
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
    # @raise [InvalidSyntax] When the required block is not given.
    # @return [Hash]
    def views(&block)
      fail InvalidSyntax, '`views` requires a block.' unless block_given?

      API::Composition.build(&block)
    end
    alias_method :composition, :views

    # Find out how many columns the current terminal is able to display.
    #
    # @example
    #   Vedeu.width
    #
    # @return [Fixnum] The total width of the current terminal.
    def width
      Terminal.width
    end

  end # API

  extend API

  trap('SIGWINCH') { Vedeu.trigger(:_resize_) }

end # Vedeu

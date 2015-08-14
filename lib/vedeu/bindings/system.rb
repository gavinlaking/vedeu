module Vedeu

  module Bindings

    # Creates system events which when called provide a variety of core
    # functions and behaviours. They are soft-namespaced using underscores.
    #
    # @note
    #   Unbinding any of these events is likely to cause problems, so I would
    #   advise leaving them alone. A safe rule: when the name starts with an
    #   underscore, it's probably used by Vedeu internally.
    #
    # :nocov:
    module System

      extend self

      # Setup events relating to running Vedeu. This method is called by Vedeu.
      #
      # @return [TrueClass]
      def setup!
        cleanup!
        clear!
        command!
        exit!
        focus_next!
        focus_prev!
        focus_by_name!
        initialize!
        keypress!
        log!
        maximise!
        mode_switch!
        refresh!
        refresh_cursor!
        refresh_group!
        resize!
        unmaximise!
      end

      private

      # Vedeu triggers this event when `:_exit_` is triggered. You can hook
      # into this to perform a special action before the application
      # terminates. Saving the user's work, session or preferences might be
      # popular here.
      #
      # @example
      #   Vedeu.trigger(:_exit_)
      #
      # @return [TrueClass]
      def cleanup!
        Vedeu.bind(:_cleanup_) do
          Vedeu.trigger(:_drb_stop_)
          Vedeu.trigger(:cleanup)
        end
      end

      # Clears the whole terminal space, or when a name is given, the named
      # interface area will be cleared.
      #
      # @example
      #   Vedeu.trigger(:_clear_)
      #   Vedeu.clear_by_name(name)
      #
      # @return [TrueClass]
      def clear!
        Vedeu.bind(:_clear_) do |name|
          if name
            Vedeu::Clear::NamedInterface.render(name)

          else
            Vedeu::Terminal.clear

          end
        end
      end

      # Will cause the triggering of the `:command` event; which you should
      # define to 'do things'
      #
      # @example
      #   Vedeu.trigger(:_command_, command)
      #
      # @return [TrueClass]
      def command!
        Vedeu.bind(:_command_) { |command| Vedeu.trigger(:command, command) }
      end

      # When triggered, Vedeu will trigger a `:cleanup` event which you can
      # define (to save files, etc) and attempt to exit.
      #
      # @example
      #   Vedeu.trigger(:_exit_)
      #   Vedeu.exit
      #
      # @return [TrueClass]
      def exit!
        Vedeu.bind(:_exit_) { Vedeu::Application.stop }
      end

      # When triggered with an interface name will focus that interface and
      # restore the cursor position and visibility.
      #
      # @example
      #   Vedeu.trigger(:_focus_by_name_, name)
      #
      # @return [TrueClass]
      def focus_by_name!
        Vedeu.bind(:_focus_by_name_) { |name| Vedeu.focus_by_name(name) }
      end

      # When triggered will focus the next interface and restore the cursor
      # position and visibility.
      #
      # @example
      #   Vedeu.trigger(:_focus_next_)
      #
      # @return [TrueClass]
      def focus_next!
        Vedeu.bind(:_focus_next_) { Vedeu.focus_next }
      end

      # When triggered will focus the previous interface and restore the cursor
      # position and visibility.
      #
      # @example
      #   Vedeu.trigger(:_focus_prev_)
      #
      # @return [TrueClass]
      def focus_prev!
        Vedeu.bind(:_focus_prev_) { Vedeu.focus_previous }
      end

      # Vedeu triggers this event when it is ready to enter the main loop.
      # Client applications can listen for this event and perform some
      # action(s), like render the first screen, interface or make a sound.
      #
      # @return [TrueClass]
      def initialize!
        Vedeu.bind(:_initialize_) do
          Vedeu.ready!
          Vedeu.trigger(:_refresh_)
        end
      end

      # Will cause the triggering of the `:key` event; which you should define
      # to 'do things'. If the `escape` key is pressed, then `key` is triggered
      # with the argument `:escape`, also an internal event `_mode_switch_` is
      # triggered. Vedeu recognises most key presses and some 'extended'
      # keypress (eg. Ctrl+J), a list of supported keypresses can be found here:
      # {Vedeu::Input#specials} and {Vedeu::Input#f_keys}.
      #
      # @example
      #   Vedeu.trigger(:_keypress_, key)
      #
      # @return [TrueClass]
      def keypress!
        Vedeu.bind(:_keypress_) { |key| Vedeu.keypress(key) }
      end

      # When triggered with a message will cause Vedeu to log the message if
      # logging is enabled in the configuration.
      #
      # @example
      #   Vedeu.trigger(:_log_, message)
      #
      # @return [TrueClass]
      def log!
        Vedeu.bind(:_log_) { |msg| Vedeu.log(type: :debug, message: msg) }
      end

      # Maximising an interface.
      #
      # @example
      #   Vedeu.trigger(:_maximise_, name)
      #
      # @return [TrueClass]
      # @see Vedeu::Geometry#maximise
      def maximise!
        Vedeu.bind(:_maximise_) do |name|
          Vedeu.geometries.by_name(name).maximise
        end
      end

      # When triggered (by default, after the user presses `escape`), Vedeu
      # switches between modes of the terminal. The idea here being
      # that the raw mode is for single keypress actions, whilst fake and cooked
      # modes allow the user to enter more elaborate commands- such as commands
      # with arguments.
      #
      # @example
      #   Vedeu.trigger(:_mode_switch_)
      #
      # @return [TrueClass]
      def mode_switch!
        Vedeu.bind(:_mode_switch_) { fail Vedeu::ModeSwitch }
      end

      # Refreshes all registered interfaces or the named interface.
      #
      # @note
      #   The interfaces will be refreshed in z-index order, meaning that
      #   interfaces with a lower z-index will be drawn first. This means
      #   overlapping interfaces will be drawn as specified.
      #   Hidden interfaces will be still refreshed in memory but not shown.
      #
      # @example
      #   Vedeu.trigger(:_refresh_)
      #   Vedeu.trigger(:_refresh_, name)
      #
      # @return [TrueClass]
      def refresh!
        Vedeu.bind(:_refresh_) do |name|
          name ? Vedeu::RefreshBuffer.by_name(name) : Vedeu::Refresh.all
        end
      end

      # Will cause the named cursor to refresh, or the cursor of the interface
      # which is currently in focus.
      #
      # @example
      #   Vedeu.trigger(:_refresh_cursor_, name)
      #
      # @return [TrueClass]
      def refresh_cursor!
        Vedeu.bind(:_refresh_cursor_) do |name|
          Vedeu::RefreshCursor.by_name(name)
        end
      end

      # Will cause all interfaces in the named group to refresh.
      #
      # @example
      #   Vedeu.trigger(:_refresh_group_, name)
      #
      # @return [TrueClass]
      def refresh_group!
        Vedeu.bind(:_refresh_group_) do |name|
          Vedeu::RefreshGroup.by_name(name)
        end
      end

      # When triggered will cause Vedeu to trigger the `:_clear_` and
      # `:_refresh_` events. Please see those events for their behaviour.
      #
      # @example
      #   Vedeu.trigger(:_resize_)
      #
      # @return [TrueClass]
      def resize!
        Vedeu.bind(:_resize_, delay: 0.25) { Vedeu.resize }
      end

      # Unmaximising an interface.
      #
      # @example
      #   Vedeu.trigger(:_unmaximise_, name)
      #
      # @return [TrueClass]
      # @see Vedeu::Geometry#unmaximise
      def unmaximise!
        Vedeu.bind(:_unmaximise_) do |name|
          Vedeu.geometries.by_name(name).unmaximise
        end
      end

    end # System

  end # Bindings
  # :nocov:

end # Vedeu

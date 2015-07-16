module Vedeu

  # Creates system events which when called provide a variety of core functions
  # and behaviours. They are soft-namespaced using underscores.
  #
  # @note
  #   Unbinding any of these events is likely to cause problems, so I would
  #   advise leaving them alone. A safe rule: if the name starts with an
  #   underscore, it's probably used by Vedeu internally.
  #
  # @api public
  # {include:file:docs/events/system.md}
  # :nocov:
  module Bindings

    module System

      extend self

      # Setup events relating to running Vedeu.
      #
      # @return [void]
      def setup!
        cleanup!
        clear!
        clear_group!
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
      def cleanup!
        Vedeu.bind(:_cleanup_) do
          Vedeu.trigger(:_drb_stop_)
          Vedeu.trigger(:cleanup)
        end
      end

      def clear!
        Vedeu.bind(:_clear_) do |name|
          if name
            Vedeu::Clear::NamedInterface.render(name)

          else
            Vedeu::Terminal.clear

          end
        end
      end

      def clear_group!
        Vedeu.bind(:_clear_group_) do |name|
          Vedeu::Clear::NamedGroup.render(name)
        end
      end

      def command!
        Vedeu.bind(:_command_) { |command| Vedeu.trigger(:command, command) }
      end

      def exit!
        Vedeu.bind(:_exit_) { Vedeu::Application.stop }
      end

      def focus_by_name!
        Vedeu.bind(:_focus_by_name_) { |name| Vedeu.focus_by_name(name) }
      end

      def focus_next!
        Vedeu.bind(:_focus_next_) { Vedeu.focus_next }
      end

      def focus_prev!
        Vedeu.bind(:_focus_prev_) { Vedeu.focus_previous }
      end

      # Vedeu triggers this event when it is ready to enter the main loop.
      # Client applications can listen for this event and perform some
      # action(s), like render the first screen, interface or make a sound.
      # When Vedeu triggers this event, the :_refresh_ event is also triggered
      # automatically.
      def initialize!
        Vedeu.bind(:_initialize_) { Vedeu.trigger(:_refresh_) }
      end

      def keypress!
        Vedeu.bind(:_keypress_) { |key| Vedeu.keypress(key) }
      end

      def log!
        Vedeu.bind(:_log_) { |msg| Vedeu.log(type: :debug, message: msg) }
      end

      def maximise!
        Vedeu.bind(:_maximise_) do |name|
          Vedeu.geometries.by_name(name).maximise
        end
      end

      # When triggered (after the user presses `escape`), Vedeu switches from a
      # "raw mode" terminal to a "cooked mode" terminal. The idea here being
      # that the raw mode is for single keypress actions, whilst cooked mode
      # allows the user to enter more elaborate commands- such as commands with
      # arguments.
      def mode_switch!
        Vedeu.bind(:_mode_switch_) { fail ModeSwitch }
      end

      def refresh!
        Vedeu.bind(:_refresh_) do |name|
          name ? Vedeu::Refresh.by_name(name) : Vedeu::Refresh.all
        end
      end

      def refresh_cursor!
        Vedeu.bind(:_refresh_cursor_) do |name|
          Vedeu::RefreshCursor.render(name)
        end
      end

      def refresh_group!
        Vedeu.bind(:_refresh_group_) { |name| Vedeu::Refresh.by_group(name) }
      end

      # When triggered will cause Vedeu to trigger the `:_clear_` and
      # `:_refresh_` events. Please see those events for their behaviour.
      def resize!
        Vedeu.bind(:_resize_, delay: 0.15) { Vedeu.resize }
      end

      def unmaximise!
        Vedeu.bind(:_unmaximise_) do |name|
          Vedeu.geometries.by_name(name).unmaximise
        end
      end

    end # System

  end # Bindings
  # :nocov:

end # Vedeu

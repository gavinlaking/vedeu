module Vedeu

  module Bindings

    module System

      extend self

      # Setup events relating to running Vedeu. This method is called by Vedeu.
      #
      # @return [TrueClass]
      def setup!
        cleanup!
        clear!
        command!
        editor!
        exit!
        initialize!
        keypress!
        log!
        maximise!
        mode_switch!
        resize!
        unmaximise!
      end

      private

      # See {file:docs/events.md#\_cleanup_}
      def cleanup!
        Vedeu.bind(:_cleanup_) do
          Vedeu.trigger(:_drb_stop_)
          Vedeu.trigger(:cleanup)
        end
      end

      # See {file:docs/events.md#\_cleanup_}
      def clear!
        Vedeu.bind(:_clear_) do |name|
          if name
            Vedeu::Clear::NamedInterface.render(name)

          else
            Vedeu::Terminal.clear

          end
        end
      end

      # See {file:docs/events.md#\_command_}
      def command!
        Vedeu.bind(:_command_) { |command| Vedeu.trigger(:command, command) }
      end

      # See {file:docs/events.md#\_editor_}
      def editor!
        Vedeu.bind(:_editor_) do |key|
          Vedeu::Editor::Editor.keypress(name: Vedeu.focus, input: key)
        end
      end

      # See {file:docs/events.md#\_exit_}
      def exit!
        Vedeu.bind(:_exit_) { Vedeu::Runtime::Application.stop }
      end

      # See {file:docs/events.md#\_initialize_}
      def initialize!
        Vedeu.bind(:_initialize_) do
          Vedeu.ready!
          Vedeu.trigger(:_refresh_)
        end
      end

      # See {file:docs/events.md#\_keypress_}
      def keypress!
        Vedeu.bind(:_keypress_) { |key| Vedeu.keypress(key) }
      end

      # See {file:docs/events.md#\_log_}
      def log!
        Vedeu.bind(:_log_) { |msg| Vedeu.log(type: :debug, message: msg) }
      end

      # See {file:docs/events.md#\_maximise_}
      def maximise!
        Vedeu.bind(:_maximise_) do |name|
          Vedeu.geometries.by_name(name).maximise
        end
      end

      # See {file:docs/events.md#\_mode_switch_}
      def mode_switch!
        Vedeu.bind(:_mode_switch_) { fail Vedeu::Error::ModeSwitch }
      end

      # See {file:docs/events.md#\_resize_}
      def resize!
        Vedeu.bind(:_resize_, delay: 0.25) { Vedeu.resize }
      end

      # See {file:docs/events.md#\_unmaximise_}
      def unmaximise!
        Vedeu.bind(:_unmaximise_) do |name|
          Vedeu.geometries.by_name(name).unmaximise
        end
      end

    end # System

  end # Bindings

end # Vedeu

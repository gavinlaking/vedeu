require_relative 'drb'
require_relative 'menus'
require_relative 'movement'
require_relative 'visibility'

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
  # {include:file:docs/events/main.md}
  module Bindings

    include Vedeu::Bindings::DRB
    include Vedeu::Bindings::Menus
    include Vedeu::Bindings::Movement
    include Vedeu::Bindings::Visibility

    # Vedeu triggers this event when `:_exit_` is triggered. You can hook into
    # this to perform a special action before the application terminates. Saving
    # the user's work, session or preferences might be popular here.
    Vedeu.bind(:_cleanup_) do
      Vedeu.trigger(:_drb_stop_)
      Vedeu.trigger(:cleanup)
    end

    Vedeu.bind(:_exit_) { Vedeu::Application.stop }

    # Vedeu triggers this event when it is ready to enter the main loop. Client
    # applications can listen for this event and perform some action(s), like
    # render the first screen, interface or make a sound. When Vedeu triggers
    # this event, the :_refresh_ event is also triggered automatically.
    Vedeu.bind(:_initialize_) { Vedeu.trigger(:_refresh_) }

    Vedeu.bind(:_keypress_) { |key| Vedeu.keypress(key) }
    Vedeu.bind(:_command_) { |command| Vedeu.trigger(:command, command) }
    Vedeu.bind(:_log_) { |msg| Vedeu.log(type: :debug, message: msg) }

    # When triggered (after the user presses `escape`), Vedeu switches from a
    # "raw mode" terminal to a "cooked mode" terminal. The idea here being that
    # the raw mode is for single keypress actions, whilst cooked mode allows the
    # user to enter more elaborate commands- such as commands with arguments.
    Vedeu.bind(:_mode_switch_) { fail ModeSwitch }

    # When triggered will cause Vedeu to trigger the `:_clear_` and `:_refresh_`
    # events. Please see those events for their behaviour.
    Vedeu.bind(:_resize_, delay: 0.15) { Vedeu.resize }

    Vedeu.bind(:_focus_by_name_) { |name| Vedeu.focus_by_name(name) }
    Vedeu.bind(:_focus_next_) { Vedeu.focus_next }
    Vedeu.bind(:_focus_prev_) { Vedeu.focus_previous }
    Vedeu.bind(:_clear_) { |name| Vedeu::Clear.by_name(name) }

    Vedeu.bind(:_refresh_) do |name|
      name ? Vedeu::Refresh.by_name(name) : Vedeu::Refresh.all
    end

    Vedeu.bind(:_refresh_cursor_) { |name| Vedeu::RefreshCursor.render(name) }
    Vedeu.bind(:_refresh_group_) { |name| Vedeu::Refresh.by_group(name) }
    Vedeu.bind(:_clear_group_) { |name| Vedeu::Clear.by_group(name) }
    Vedeu.bind(:_maximise_) { |name| Vedeu.geometries.by_name(name).maximise }

    Vedeu.bind(:_unmaximise_) do |name|
      Vedeu.geometries.by_name(name).unmaximise
    end

  end # Bindings

end # Vedeu

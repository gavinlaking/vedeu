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

    # When triggered, Vedeu will trigger a `:cleanup` event which you can define
    # (to save files, etc) and attempt to exit.
    Vedeu.bind(:_exit_) { Vedeu::Application.stop }

    # Vedeu triggers this event when it is ready to enter the main loop. Client
    # applications can listen for this event and perform some action(s), like
    # render the first screen, interface or make a sound. When Vedeu triggers
    # this event, the :_refresh_ event is also triggered automatically.
    Vedeu.bind(:_initialize_) { Vedeu.trigger(:_refresh_) }

    # Will cause the triggering of the `:key` event; which
    # you should define to 'do things'. If the `escape` key is pressed, then
    # `key` is triggered with the argument `:escape`, also an internal event
    # `_mode_switch_` is triggered.
    Vedeu.bind(:_keypress_) { |key| Vedeu.keypress(key) }

    # Will cause the triggering of the `:command` event; which you should define
    # to 'do things'.
    Vedeu.bind(:_command_) { |command| Vedeu.trigger(:command, command) }

    # When triggered with a message will cause Vedeu to log the message if
    # logging is enabled in the configuration.
    Vedeu.bind(:_log_) { |msg| Vedeu.log(type: :debug, message: msg) }

    # When triggered (after the user presses `escape`), Vedeu switches from a
    # "raw mode" terminal to a "cooked mode" terminal. The idea here being that
    # the raw mode is for single keypress actions, whilst cooked mode allows the
    # user to enter more elaborate commands- such as commands with arguments.
    Vedeu.bind(:_mode_switch_) { fail ModeSwitch }

    # When triggered will cause Vedeu to trigger the `:_clear_` and `:_refresh_`
    # events. Please see those events for their behaviour.
    Vedeu.bind(:_resize_, delay: 0.15) { Vedeu.resize }

    # When triggered will return the current position of the cursor.
    Vedeu.bind(:_cursor_position_) do |name|
      Vedeu.cursors.by_name(name).position
    end

    # When triggered with an interface name will focus that interface and
    # restore the cursor position and visibility.
    Vedeu.bind(:_focus_by_name_) { |name| Vedeu.focus_by_name(name) }

    # When triggered will focus the next interface and restore the cursor
    # position and visibility.
    Vedeu.bind(:_focus_next_) { Vedeu.focus_next }

    # When triggered will focus the previous interface and restore the cursor
    # position and visibility.
    Vedeu.bind(:_focus_prev_) { Vedeu.focus_previous }

    # Clears the whole terminal space, or the named interface area to be cleared
    # if given.
    Vedeu.bind(:_clear_) { |name| Vedeu::Clear.by_name(name) }

    # Will cause all interfaces to refresh, or the named interface if given.
    #
    # @note
    #   Hidden interfaces will be still refreshed in memory but not shown.
    Vedeu.bind(:_refresh_) do |name|
      name ? Vedeu::Refresh.by_name(name) : Vedeu::Refresh.all
    end

    # Will cause the named cursor to refresh, or the cursor of the interface
    # which is currently in focus.
    Vedeu.bind(:_refresh_cursor_) { |name| Vedeu::RefreshCursor.render(name) }

    # Will cause all interfaces in the named group to refresh.
    Vedeu.bind(:_refresh_group_) { |name| Vedeu::Refresh.by_group(name) }

    # Clears the spaces occupied by the interfaces belonging to the named group.
    Vedeu.bind(:_clear_group_) { |name| Vedeu::Clear.by_group(name) }


    # @see Vedeu::Geometry#maximise
    Vedeu.bind(:_maximise_) { |name| Vedeu.geometries.by_name(name).maximise }

    # @see Vedeu::Geometry#unmaximise
    Vedeu.bind(:_unmaximise_) do |name|
      Vedeu.geometries.by_name(name).unmaximise
    end

  end # Bindings

end # Vedeu

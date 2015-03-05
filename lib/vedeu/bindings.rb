require 'vedeu/events/event'

module Vedeu

  # Creates system events which when called provide a variety of core functions
  # and behaviours. They are soft-namespaced using underscores.
  #
  # @note
  #   Unbinding any of these events is likely to cause problems, so I would
  #   advise leaving them alone. A safe rule: if the name starts with an
  #   underscore, it's probably used by Vedeu internally.
  #
  # :nocov:
  #
  module Bindings

    # Vedeu triggers this event when `:_exit_` is triggered. You can hook into
    # this to perform a special action before the application terminates. Saving
    # the user's work, session or preferences might be popular here.
    Vedeu.bind(:_cleanup_) do
      Vedeu.trigger(:_drb_stop_, 'via :cleanup')
      Vedeu.trigger(:cleanup)
    end

    Vedeu.bind(:_drb_input_) do |data|
      Vedeu.log(type: :drb, message: 'Sending input')
      Vedeu.trigger(:_keypress_, data)
    end

    Vedeu.bind(:_drb_retrieve_output_)  do
      Vedeu.log(type: :drb, message: 'Retrieving output')
      Vedeu::VirtualBuffer.retrieve
    end

    Vedeu.bind(:_drb_store_output_)  do |data|
      Vedeu.log(type: :drb, message: 'Storing output')
      Vedeu::VirtualBuffer.store(Vedeu::Terminal.virtual.output(data))
    end

    Vedeu.bind(:_drb_restart_) do
      Vedeu.log(type: :drb, message: 'Attempting to restart')
      Vedeu::Distributed::Server.restart
    end

    Vedeu.bind(:_drb_start_)   do
      Vedeu.log(type: :drb, message: 'Attempting to start')
      Vedeu::Distributed::Server.start
    end

    Vedeu.bind(:_drb_status_)  do
      Vedeu.log(type: :drb, message: 'Fetching status')
      Vedeu::Distributed::Server.status
    end

    Vedeu.bind(:_drb_stop_) do |message|
      Vedeu.log(type: :drb, message: "Attempting to stop (#{message})")
      Vedeu::Distributed::Server.stop
    end

    # When triggered, Vedeu will trigger a `:cleanup` event which you can define
    # (to save files, etc) and attempt to exit.
    Vedeu.bind(:_exit_) { Vedeu::Application.stop      }

    # Vedeu triggers this event when it is ready to enter the main loop. Client
    # applications can listen for this event and perform some action(s), like
    # render the first screen, interface or make a sound. When Vedeu triggers
    # this event, the :_refresh_ event is also triggered automatically.
    Vedeu.bind(:_initialize_) { Vedeu.trigger(:_refresh_)    }

    # Triggering this event will cause the triggering of the `:key` event; which
    # you should define to 'do things'. If the `escape` key is pressed, then
    # `key` is triggered with the argument `:escape`, also an internal event
    # `_mode_switch_` is triggered.
    Vedeu.bind(:_keypress_) { |key| Vedeu.keypress(key) }

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
    Vedeu.bind(:_resize_, { delay: 0.25 }) { Vedeu.resize }

    # Hide the cursor of the named interface or interface currently in focus.
    Vedeu.bind(:_cursor_hide_) do |name|
      named = if name
        Vedeu.cursors.by_name(name)

      else
        Vedeu.cursor

      end

      ToggleCursor.hide(named)
    end

    # Show the cursor of the named interface or interface currently in focus.
    Vedeu.bind(:_cursor_show_) do |name|
      named = if name
        Vedeu.cursors.by_name(name)

      else
        Vedeu.cursor

      end

      ToggleCursor.show(named)
    end

    # Move the cursor down one character in the interface currently in focus.
    # Will not exceed the border or boundary of the interface.
    Vedeu.bind(:_cursor_down_) do
      interface = Vedeu.interfaces.current

      MoveCursor.down(Vedeu.cursor, interface)

      Refresh.by_focus
    end

    # Move the cursor left one character in the interface currently in focus.
    # Will not exceed the border or boundary of the interface.
    Vedeu.bind(:_cursor_left_) do
      interface = Vedeu.interfaces.current

      MoveCursor.left(Vedeu.cursor, interface)

      Refresh.by_focus
    end

    # Move the cursor right one character in the interface currently in focus.
    # Will not exceed the border or boundary of the interface.
    Vedeu.bind(:_cursor_right_) do
      interface = Vedeu.interfaces.current

      MoveCursor.right(Vedeu.cursor, interface)

      Refresh.by_focus
    end

    # Move the cursor up one character in the interface currently in focus.
    # Will not exceed the border or boundary of the interface.
    Vedeu.bind(:_cursor_up_) do
      interface = Vedeu.interfaces.current

      MoveCursor.up(Vedeu.cursor, interface)

      Refresh.by_focus
    end

    # Moves the cursor to the top left position of the interface currently in
    # focus; respecting a border if present.
    Vedeu.bind(:_cursor_origin_) do
      interface = Vedeu.interfaces.current

      MoveCursor.origin(Vedeu.cursor, interface)

      Refresh.by_focus
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

    # Requires target menu name as argument. Makes the last menu item the
    # current menu item.
    Vedeu.bind(:_menu_bottom_) { |name| Vedeu.menus.find(name).bottom_item }

    # Requires target menu name as argument. Returns the current menu item.
    Vedeu.bind(:_menu_current_) { |name| Vedeu.menus.find(name).current_item }

    # Requires target menu name as argument. Deselects all menu items.
    Vedeu.bind(:_menu_deselect_) { |name| Vedeu.menus.find(name).deselect_item }

    # Requires target menu name as argument. Returns all the menu items with
    # respective `current` or `selected` boolean indicators.
    Vedeu.bind(:_menu_items_) { |name| Vedeu.menus.find(name).items }

    # Requires target menu name as argument. Makes the next menu item the
    # current menu item, until it reaches the last item.
    Vedeu.bind(:_menu_next_) { |name| Vedeu.menus.find(name).next_item }

    # Requires target menu name as argument. Makes the previous menu item the
    # current menu item, until it reaches the first item.
    Vedeu.bind(:_menu_prev_) { |name| Vedeu.menus.find(name).prev_item }

    # Requires target menu name as argument. Returns the selected menu item.
    Vedeu.bind(:_menu_selected_) { |name| Vedeu.menus.find(name).selected_item }

    # Requires target menu name as argument. Makes the current menu item also
    # the selected menu item.
    Vedeu.bind(:_menu_select_) { |name| Vedeu.menus.find(name).select_item }

    # Requires target menu name as argument. Makes the first menu item the
    # current menu item.
    Vedeu.bind(:_menu_top_) { |name| Vedeu.menus.find(name).top_item }

    # Requires target menu name as argument. Returns a subset of the menu items;
    # starting at the current item to the last item.
    Vedeu.bind(:_menu_view_) { |name| Vedeu.menus.find(name).view }

    # Clears the whole terminal space, or the named interface area to be cleared
    # if given.
    Vedeu.bind(:_clear_) do |name|
      if name && Vedeu.interfaces.registered?(name)
        Vedeu::Output.clear(Vedeu.interfaces.find(name))

      else
        Vedeu::Terminal.virtual.clear if Vedeu::Configuration.drb?

        Vedeu::Terminal.clear
      end
    end

    # Triggering this event will cause all interfaces to refresh, or the named
    # interface if given.
    Vedeu.bind(:_refresh_) do |name|
      if name
        Vedeu::Refresh.by_name(name)

      else
        Vedeu::Refresh.all

      end
    end

    # Triggering this event will cause all interfaces in the named group to
    # refresh.
    Vedeu.bind(:_refresh_group_) do |name|
      Vedeu::Refresh.by_group(name)
    end

  end # Bindings
  # :nocov:

end # Vedeu

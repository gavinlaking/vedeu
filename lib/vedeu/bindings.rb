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

    Vedeu.bind(:_drb_input_) do |data, type|
      Vedeu.log(type: :drb, message: "Sending input (#{type})")

      case type
      when :command then Vedeu.trigger(:_command_, data)
      else Vedeu.trigger(:_keypress_, data)
      end
    end

    Vedeu.bind(:_drb_retrieve_output_) do
      Vedeu.log(type: :drb, message: 'Retrieving output')
      Vedeu::VirtualBuffer.retrieve
    end

    Vedeu.bind(:_drb_store_output_) do |data|
      Vedeu.log(type: :drb, message: 'Storing output')
      Vedeu::VirtualBuffer.store(Vedeu::Terminal.virtual.output(data))
    end

    Vedeu.bind(:_drb_restart_) { Vedeu::Distributed::Server.restart }
    Vedeu.bind(:_drb_start_)   { Vedeu::Distributed::Server.start }
    Vedeu.bind(:_drb_status_)  { Vedeu::Distributed::Server.status }
    Vedeu.bind(:_drb_stop_)    { Vedeu::Distributed::Server.stop }

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
    Vedeu.bind(:_keypress_) do |key|
      Vedeu.trigger(:key, key)

      Vedeu.keypress(key)
    end

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
    Vedeu.bind(:_resize_, delay: 0.25) { Vedeu.resize }

    Vedeu.bind(:tick) do |time|
      Vedeu.log(type: :debug, message: "Tick: #{time}")
    end
    Vedeu.bind(:tock) do |time|
      Vedeu.log(type: :debug, message: "Tock: #{time}")
    end

    # Hide the cursor of the named interface or interface currently in focus.
    Vedeu.bind(:_cursor_hide_) do |name|
      Vedeu::Visibility.for_cursor(name).hide
    end

    # Show the cursor of the named interface or interface currently in focus.
    Vedeu.bind(:_cursor_show_) do |name|
      Vedeu::Visibility.for_cursor(name).show
    end

    # @see {Vedeu::Move}
    Vedeu.bind(:_cursor_down_) { |name| Vedeu::Move.by_name(:down, name) }

    # @see {Vedeu::Move}
    Vedeu.bind(:_cursor_left_) { |name| Vedeu::Move.by_name(:left, name) }

    # @see {Vedeu::Move}
    Vedeu.bind(:_cursor_right_) { |name| Vedeu::Move.by_name(:right, name) }

    # @see {Vedeu::Move}
    Vedeu.bind(:_cursor_up_) { |name| Vedeu::Move.by_name(:up, name) }

    # @see {Vedeu::Move}
    Vedeu.bind(:_cursor_origin_) { |name| Vedeu::Move.by_name(:origin, name) }

    # @see {Vedeu::Move}
    Vedeu.bind(:_cursor_reset_) { |name| Vedeu.trigger(:_cursor_origin_, name) }

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
      if name
        Vedeu::Clear.clear(Vedeu.interfaces.by_name(name),
                           clear_border: true, use_terminal_colours: true)

      else
        Vedeu::Terminal.virtual.clear if Vedeu::Configuration.drb?

        Vedeu::Terminal.clear
      end
    end

    # Clears the spaces occupied by the interfaces belonging to the named group.
    Vedeu.bind(:_clear_group_) do |group_name|
      Vedeu.groups.find(group_name).members.each do |interface_name|
        Vedeu.trigger(:_clear_, interface_name)
      end
    end

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

    # Will clear the terminal and then show all of the interfaces belonging to
    # the named group.
    Vedeu.bind(:_show_group_) do |name|
      Vedeu.trigger(:_clear_)

      Vedeu.trigger(:_refresh_group_, name)
    end

    # Will hide all of the interfaces belonging to the named group. Useful for
    # hiding part of that which is currently displaying in the terminal.
    #
    # @note
    #   This may be rarely used, since the action of showing a group using
    #   `Vedeu.trigger(:_show_group_, group_name)` will effectively clear the
    #   terminal and show the new group.
    Vedeu.bind(:_hide_group_) do |name|
      Vedeu.trigger(:_clear_group_, name)
    end

    # Will hide the named interface. If the interface is currently visible, it
    # will be cleared- rendered blank. To show the interface, the
    # ':_show_interface_' event should be triggered.
    # Triggering the ':_hide_group_' event to which this named interface belongs
    # will also hide the interface.
    Vedeu.bind(:_hide_interface_) do |name|
      Vedeu.buffers.by_name(name).hide
    end

    # Will show the named interface. If the interface is currently invisible, it
    # will be shown- rendered with its latest content. To hide the interface,
    # the ':_hide_interface_' event should be triggered.
    # Triggering the ':_show_group_' event to which this named interface belongs
    # will also show the interface.
    Vedeu.bind(:_show_interface_) do |name|
      Vedeu.buffers.by_name(name).show
    end

    # Will toggle the visibility of the named interface. If the interface is
    # currently visible, the area it occupies will be clears and the interface
    # will be marked invisible. If the interface is invisible, then the
    # interface will be marked visible and rendered in the area it occupies.
    #
    # @note
    #   If an interface is marked visible whilst another view is occupying some
    #   or all of the interface's current position, the interface will overwrite
    #   this area- this may cause visual corruption.
    Vedeu.bind(:_toggle_interface_) do |name|
      if name && Vedeu.interfaces.registered?(name)
        interface = Vedeu.interfaces.find(name)

        if interface.visible?
          Vedeu.trigger(:_hide_interface_, name)

        else
          Vedeu.trigger(:_show_interface_, name)

        end
      end
    end

    Vedeu.bind(:_maximise_) do |name|
      Vedeu.geometries.by_name(name).maximise

      Vedeu.trigger(:_refresh_, name)
    end

    Vedeu.bind(:_unmaximise_) do |name|
      Vedeu.trigger(:_clear_, name)

      Vedeu.geometries.by_name(name).unmaximise

      Vedeu.trigger(:_refresh_, name)
    end

  end # Bindings
  # :nocov:

end # Vedeu

require 'vedeu/events/event'

module Vedeu

  # Creates system events which when called provide a variety of core functions
  # and behaviours.
  #
  # @note
  #   Unbinding any of these events is likely to cause problems, so I would
  #   advise leaving them alone. A safe rule: if the name starts with an
  #   underscore, it's probably used by Vedeu internally.
  module Bindings
    # :nocov:

    # System events needed by Vedeu to run.
    Vedeu.bind(:_clear_)                   { Vedeu::Terminal.clear_screen }
    Vedeu.bind(:_exit_)                    { Vedeu::Application.stop      }
    Vedeu.bind(:_initialize_)              { Vedeu.trigger(:_refresh_)    }
    Vedeu.bind(:_keypress_)                { |key| Vedeu.keypress(key)    }
    Vedeu.bind(:_log_)                     { |msg| Vedeu.log(msg)         }
    Vedeu.bind(:_mode_switch_)             { fail ModeSwitch              }
    Vedeu.bind(:_resize_, { delay: 0.25 }) { Vedeu.resize                 }

    # System events which when called will update the cursor visibility
    # accordingly for the interface in focus, or the named interface. Also
    # includes events to move the cursor in the direction specified; these will
    # update the cursor position according to the interface in focus.
    Vedeu.bind(:_cursor_hide_) do
      current = Vedeu.cursors_repository.current

      ToggleCursor.hide(current)
    end

    Vedeu.bind(:_cursor_show_) do
      current = Vedeu.cursors_repository.current

      ToggleCursor.show(current)
    end

    Vedeu.bind(:_cursor_hide_by_name_) do |name|
      named = Vedeu.cursors_repository.by_name(name)

      ToggleCursor.hide(named)
    end

    Vedeu.bind(:_cursor_show_by_name_) do |name|
      named = Vedeu.cursors_repository.by_name(name)

      ToggleCursor.show(named)
    end

    Vedeu.bind(:_cursor_down_) do
      cursor    = Vedeu.cursors_repository.current
      interface = Vedeu.interfaces_repository.current

      MoveCursor.down(cursor, nterface)

      Refresh.by_focus
    end

    Vedeu.bind(:_cursor_left_) do
      cursor = Vedeu.cursors_repository.current
      interface = Vedeu.interfaces_repository.current

      MoveCursor.left(cursor, interface)

      Refresh.by_focus
    end

    Vedeu.bind(:_cursor_right_) do
      cursor = Vedeu.cursors_repository.current
      interface = Vedeu.interfaces_repository.current

      MoveCursor.right(cursor, interface)

      Refresh.by_focus
    end

    Vedeu.bind(:_cursor_up_) do
      cursor = Vedeu.cursors_repository.current
      interface = Vedeu.interfaces_repository.current

      MoveCursor.up(cursor, interface)

      Refresh.by_focus
    end

    Vedeu.bind(:_cursor_origin_) do
      cursor = Vedeu.cursors_repository.current
      interface = Vedeu.interfaces_repository.current

      MoveCursor.origin(cursor, interface)

      Refresh.by_focus
    end

    # System events which when called will change which interface is currently
    # focussed. When the interface is brought into focus, its cursor position
    # and visibility is restored.
    Vedeu.bind(:_focus_by_name_) { |name| Vedeu.focus_by_name(name) }
    Vedeu.bind(:_focus_next_)    {        Vedeu.focus_next          }
    Vedeu.bind(:_focus_prev_)    {        Vedeu.focus_previous      }

    # System events which when called with the appropriate menu name will
    # update the menu accordingly.
    Vedeu.bind(:_menu_bottom_)   { |name| Vedeu::Menus.use(name).bottom_item   }
    Vedeu.bind(:_menu_current_)  { |name| Vedeu::Menus.use(name).current_item  }
    Vedeu.bind(:_menu_deselect_) { |name| Vedeu::Menus.use(name).deselect_item }
    Vedeu.bind(:_menu_items_)    { |name| Vedeu::Menus.use(name).items         }
    Vedeu.bind(:_menu_next_)     { |name| Vedeu::Menus.use(name).next_item     }
    Vedeu.bind(:_menu_prev_)     { |name| Vedeu::Menus.use(name).prev_item     }
    Vedeu.bind(:_menu_selected_) { |name| Vedeu::Menus.use(name).selected_item }
    Vedeu.bind(:_menu_select_)   { |name| Vedeu::Menus.use(name).select_item   }
    Vedeu.bind(:_menu_top_)      { |name| Vedeu::Menus.use(name).top_item      }
    Vedeu.bind(:_menu_view_)     { |name| Vedeu::Menus.use(name).view          }

    # System event to refresh all registered interfaces.
    Vedeu.bind(:_refresh_) { Vedeu::Refresh.all }

  end # Bindings
  # :nocov:

end # Vedeu

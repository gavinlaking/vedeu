require 'vedeu/events/event'

module Vedeu

  module API

    def_delegators Vedeu::Event, :bind, :trigger, :unbind

  end

  # Creates system events which when called provide a variety of core functions
  # and behaviours.
  #
  # @note
  #   Unbinding any of these events is likely to cause problems, so I would
  #   advise leaving them alone. A safe rule: if the name starts with an
  #   underscore, it's probably used by Vedeu internally.
  #
  # :nocov:
  #
  module Bindings

    # System events needed by Vedeu to run.
    Vedeu.bind(:_clear_)                   { Vedeu::Terminal.clear        }
    Vedeu.bind(:_cleanup_) do
      Vedeu.trigger(:_drb_stop_)
      Vedeu.trigger(:cleanup)
    end

    Vedeu.bind(:_drb_input_)   do |data|
      Vedeu.drb_log('Sending input')
      Vedeu::Distributed::Server.input(data)
    end

    Vedeu.bind(:_drb_output_)  do |data|
      Vedeu.drb_log('Sending output')
      Vedeu::Distributed::Server.output(data)
    end

    Vedeu.bind(:_drb_restart_) do
      Vedeu.drb_log('Attempting to restart')
      Vedeu::Distributed::Server.restart
    end

    Vedeu.bind(:_drb_start_)   do
      Vedeu.drb_log('Attempting to start')
      Vedeu::Distributed::Server.start
    end

    Vedeu.bind(:_drb_status_)  do
      Vedeu.drb_log('Fetching status')
      Vedeu::Distributed::Server.status
    end

    Vedeu.bind(:_drb_stop_)    do
      Vedeu.drb_log('Attempting to stop')
      Vedeu::Distributed::Server.stop
    end

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
      ToggleCursor.hide(Vedeu.cursor)
    end

    Vedeu.bind(:_cursor_show_) do
      ToggleCursor.show(Vedeu.cursor)
    end

    Vedeu.bind(:_cursor_hide_by_name_) do |name|
      named = Vedeu.cursors.by_name(name)

      ToggleCursor.hide(named)
    end

    Vedeu.bind(:_cursor_show_by_name_) do |name|
      named = Vedeu.cursors.by_name(name)

      ToggleCursor.show(named)
    end

    Vedeu.bind(:_cursor_down_) do
      interface = Vedeu.interfaces.current

      MoveCursor.down(Vedeu.cursor, interface)

      Refresh.by_focus
    end

    Vedeu.bind(:_cursor_left_) do
      interface = Vedeu.interfaces.current

      MoveCursor.left(Vedeu.cursor, interface)

      Refresh.by_focus
    end

    Vedeu.bind(:_cursor_right_) do
      interface = Vedeu.interfaces.current

      MoveCursor.right(Vedeu.cursor, interface)

      Refresh.by_focus
    end

    Vedeu.bind(:_cursor_up_) do
      interface = Vedeu.interfaces.current

      MoveCursor.up(Vedeu.cursor, interface)

      Refresh.by_focus
    end

    Vedeu.bind(:_cursor_origin_) do
      interface = Vedeu.interfaces.current

      MoveCursor.origin(Vedeu.cursor, interface)

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
    Vedeu.bind(:_menu_bottom_)   { |name| Vedeu.menus.find(name).bottom_item   }
    Vedeu.bind(:_menu_current_)  { |name| Vedeu.menus.find(name).current_item  }
    Vedeu.bind(:_menu_deselect_) { |name| Vedeu.menus.find(name).deselect_item }
    Vedeu.bind(:_menu_items_)    { |name| Vedeu.menus.find(name).items         }
    Vedeu.bind(:_menu_next_)     { |name| Vedeu.menus.find(name).next_item     }
    Vedeu.bind(:_menu_prev_)     { |name| Vedeu.menus.find(name).prev_item     }
    Vedeu.bind(:_menu_selected_) { |name| Vedeu.menus.find(name).selected_item }
    Vedeu.bind(:_menu_select_)   { |name| Vedeu.menus.find(name).select_item   }
    Vedeu.bind(:_menu_top_)      { |name| Vedeu.menus.find(name).top_item      }
    Vedeu.bind(:_menu_view_)     { |name| Vedeu.menus.find(name).view          }

    # System event to refresh all registered interfaces.
    Vedeu.bind(:_refresh_) { Vedeu::Refresh.all }

  end # Bindings
  # :nocov:

end # Vedeu

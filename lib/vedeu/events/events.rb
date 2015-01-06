require 'vedeu/support/repository'
require 'vedeu/models/collection'
require 'vedeu/events/event'

module Vedeu

  extend Forwardable
  extend self

  # Provides a mechanism for storing and retrieving events by name. A single
  # name can contain many events. Also, an event can trigger other events.
  #
  # @todo I really don't like the 'hashiness' of this. (GL 2014-10-29)
  #
  # @api private
  class Events < Repository

    # Unregisters the event by name, effectively deleting the associated events
    # bound with it also.
    #
    # @param name [String]
    # @return [Boolean]
    def unevent(name)
      if Vedeu.events_repository.registered?(name)
        remove(name)
        true

      else
        false

      end
    end

    private

  end # Events

  def_delegators Vedeu::Events, :event, :trigger, :unevent

  # :nocov:

  # System events needed by Vedeu to run.
  Vedeu.event(:_clear_)                   { Vedeu::Terminal.clear_screen }
  Vedeu.event(:_exit_)                    { Vedeu::Application.stop      }
  Vedeu.event(:_initialize_)              { Vedeu.trigger(:_refresh_)    }
  Vedeu.event(:_keypress_)                { |key| Vedeu.keypress(key)    }
  Vedeu.event(:_log_)                     { |msg| Vedeu.log(msg)         }
  Vedeu.event(:_mode_switch_)             { fail ModeSwitch              }
  Vedeu.event(:_resize_, { delay: 0.25 }) { Vedeu.resize                 }

  # System events which when called will update the cursor visibility
  # accordingly for the interface in focus, or the named interface. Also
  # includes events to move the cursor in the direction specified; these will
  # update the cursor position according to the interface in focus.
  Vedeu.event(:_cursor_hide_) do
    current = Vedeu.cursors_repository.current

    ToggleCursor.hide(current)
  end

  Vedeu.event(:_cursor_show_) do
    current = Vedeu.cursors_repository.current

    ToggleCursor.show(current)
  end

  Vedeu.event(:_cursor_hide_by_name_) do |name|
    named = Vedeu.cursors_repository.by_name(name)

    ToggleCursor.hide(named)
  end

  Vedeu.event(:_cursor_show_by_name_) do |name|
    named = Vedeu.cursors_repository.by_name(name)

    ToggleCursor.show(named)
  end

  Vedeu.event(:_cursor_down_) do
    cursor    = Vedeu.cursors_repository.current
    interface = Vedeu.interfaces_repository.current

    MoveCursor.down(cursor, nterface)

    Refresh.by_focus
  end

  Vedeu.event(:_cursor_left_) do
    cursor = Vedeu.cursors_repository.current
    interface = Vedeu.interfaces_repository.current

    MoveCursor.left(cursor, interface)

    Refresh.by_focus
  end

  Vedeu.event(:_cursor_right_) do
    cursor = Vedeu.cursors_repository.current
    interface = Vedeu.interfaces_repository.current

    MoveCursor.right(cursor, interface)

    Refresh.by_focus
  end

  Vedeu.event(:_cursor_up_) do
    cursor = Vedeu.cursors_repository.current
    interface = Vedeu.interfaces_repository.current

    MoveCursor.up(cursor, interface)

    Refresh.by_focus
  end

  Vedeu.event(:_cursor_origin_) do
    cursor = Vedeu.cursors_repository.current
    interface = Vedeu.interfaces_repository.current

    MoveCursor.origin(cursor, interface)

    Refresh.by_focus
  end

  # System events which when called will change which interface is currently
  # focussed. When the interface is brought into focus, its cursor position
  # and visibility is restored.
  # From: Focus (top)
  Vedeu.event(:_focus_by_name_) { |name| Vedeu::Focus.by_name(name) }
  Vedeu.event(:_focus_next_)    { Vedeu::Focus.next_item }
  Vedeu.event(:_focus_prev_)    { Vedeu::Focus.prev_item }

  # System events which when called with the appropriate menu name will
  # update the menu accordingly.
  # From: Menus (top)
  Vedeu.event(:_menu_bottom_)   { |name| Vedeu::Menus.use(name).bottom_item   }
  Vedeu.event(:_menu_current_)  { |name| Vedeu::Menus.use(name).current_item  }
  Vedeu.event(:_menu_deselect_) { |name| Vedeu::Menus.use(name).deselect_item }
  Vedeu.event(:_menu_items_)    { |name| Vedeu::Menus.use(name).items         }
  Vedeu.event(:_menu_next_)     { |name| Vedeu::Menus.use(name).next_item     }
  Vedeu.event(:_menu_prev_)     { |name| Vedeu::Menus.use(name).prev_item     }
  Vedeu.event(:_menu_selected_) { |name| Vedeu::Menus.use(name).selected_item }
  Vedeu.event(:_menu_select_)   { |name| Vedeu::Menus.use(name).select_item   }
  Vedeu.event(:_menu_top_)      { |name| Vedeu::Menus.use(name).top_item      }
  Vedeu.event(:_menu_view_)     { |name| Vedeu::Menus.use(name).view          }

  # System event to refresh all registered interfaces.
  Vedeu.event(:_refresh_) { Vedeu::Refresh.all }

  # :nocov:

end # Vedeu

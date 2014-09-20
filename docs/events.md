## Vedeu Events

Vedeu provides an event mechanism to facilitate the functionality of your application. The events are either Vedeu defined, ie. system events or user defined, ie. user events.

Events described in this document assume that you have included Vedeu in your class:

```ruby
  class SomeClassInYourApplication
    include Vedeu

    ...
```

## System Events

System events generally control the internal state of Vedeu with respects to your application. They are soft-namespaced using underscores.

### `:_clear_`

Clears the whole terminal space.

### `:_cursor_up_`

Moves the cursor for the focussed interface up one row, but will not exceed the boundary of the interface.

### `:_cursor_right_`

Moves the cursor for the focussed interface right one column, but will not exceed the boundary of the interface.

### `:_cursor_down_`

Moves the cursor for the focussed interface down one row, but will not exceed the boundary of the interface.

### `:_cursor_left_`

Moves the cursor for the focussed interface left one column, but will not exceed the boundary of the interface.

### `:_cursor_hide_`

Hides the cursor for the focussed interface.

### `:_cursor_show_`

Shows the cursor for the focussed interface.

### `:_cursor_refresh_`

Refreshes the cursor for the focussed interface.

### `:_exit_`

When triggered, Vedeu will trigger a `:_cleanup_` event which you can define (to save files, etc) and attempt to exit.

### `:_focus_by_name_`

When triggered with an interface name will focus that interface and restore the cursor position and visibility.

### `:_focus_next_`

When triggered will focus the next interface and restore the cursor position and visibility.

### `:_focus_prev_`

When triggered will focus the previous interface and restore the cursor position and visibility.

### `:_keypress_`

Triggering this event will cause the triggering of the `:key` event; which you should define to 'do things'. If the `escape` key is pressed, then `key` is triggered with the argument `:escape`, also an internal event `_mode_switch_` is triggered.

### `:_log_`

When triggered with a message will cause Vedeu to log the message if logging is enabled in the configuration.

### `:_menu_current_`

Requires target menu name as argument. Returns the current menu item.

### `:_menu_selected_`

Requires target menu name as argument. Returns the selected menu item.

### `:_menu_next_`

Requires target menu name as argument. Makes the next menu item the current menu item, until it reaches the last item.

### `:_menu_prev_`

Requires target menu name as argument. Makes the previous menu item the current menu item, until it reaches the first item.

### `:_menu_top_`

Requires target menu name as argument. Makes the first menu item the current menu item.

### `:_menu_bottom_`

Requires target menu name as argument. Makes the last menu item the current menu item.

### `:_menu_select_`

Requires target menu name as argument. Makes the current menu item also the selected menu item.

### `:_menu_deselect_`

Requires target menu name as argument. Deselects all menu items.

### `:_menu_items_`

Requires target menu name as argument. Returns all the menu items with respective `current` or `selected` boolean indicators.

### `:_menu_view_`

Requires target menu name as argument. Returns a subset of the menu items; starting at the current item to the last item.

### `:_mode_switch_`

When triggered (after the user presses `escape`), Vedeu switches from a "raw mode" terminal to a "cooked mode" terminal. The idea here being that the raw mode is for single keypress actions, whilst cooked mode allows the user to enter more elaborate commands- such as commands with arguments.

### `:_refresh_`

Triggering this event will cause all interfaces to refresh.

### `:_refresh_group_(group_name)_`

Will refresh all interfaces belonging to this group. E.g. `_refresh_group_home_` will refresh all interfaces with the group of `home`.

### `:_refresh_(interface_name)_`

Will refresh the interface with this name. E.g. `_refresh_widget_` will refresh the interface `widget`.

### `:_resize_`

When triggered will cause Vedeu to trigger the `:_clear_` and `:_refresh_` events. Please see those events for their behaviour.


##### Notes:

System events can be handled or triggered by your application also, but overriding or adding additional events to the Vedeu system event namespace may cause unpredictable results. It is recommended to only to hook into events like :_cleanup_, :_initialize_ and :key if you need to do something respective to those events.

... TODO ... What about events in Vedeu::Menu?

... TODO ... More information about system events.


### User Events

User events allow you to orchestrate behaviour within your application, ie. the user presses a specific key, you trigger an event to make something happen. Eg. pressing 'p' instructs the player to play.

## Pre-defined User Events

Vedeu pre-defines a few user events, which client applications can listen for, or trigger themselves.

### `:_cleanup_`

Vedeu triggers this event when `:_exit_` is triggered. You can hook into this to perform a special action before the application terminates. Saving the user's work, session or preferences might be popular here.

### `:_initialize_`

Vedeu triggers this event when it is ready to enter the main loop. Client applications can listen for this event and perform some action(s), like render the first screen, interface or make a sound.

#### How to define user events

```ruby
event :event_name do |arg1, arg2|
  ...

  # Things that should happen when the event is triggered; these can be method
  # calls or the triggering of another event or events.

  ...
end
```

... TODO ... How to define.


#### How to trigger user events

... TODO ... How to trigger.


#### More information.

... TODO ... More information about user events.



## Vedeu Events

Vedeu provides an event mechanism to facilitate the functionality of your
application. The events are either Vedeu defined, ie. system events or 
user defined, ie. user events.

Events described in this document assume that you have included Vedeu in your
class:

```ruby
  class SomeClassInYourApplication
    include Vedeu

    ...
```

### System Events

System events generally control the internal state of Vedeu with respects to
your application. They are soft-namespaced using underscores.

#### `:_cleanup_`

This event is fired by Vedeu when `:_exit_` is triggered. You can hook into this to perform a special action before the application terminates. Saving the user's work, session or preferences might be popular here.

#### `:_clear_`

Clears the whole terminal space.

#### `:_exit_` 

When triggered, Vedeu will trigger a `:_cleanup_` event which you can define (to save files, etc) and attempt to exit.

#### `:_focus_by_name_` 

When triggered with an interface name will focus that interface.

#### `:_focus_next_`

When triggered will focus the next interface. 

#### `:_focus_prev_`

When triggered will focus the previous interface.

#### `:_initialize_`

Special event which Vedeu triggers when it is ready to enter the main loop. Client applications can listen for this event and perform some action(s), like render the first screen, interface or make a sound.

#### `:_keypress_`

Triggering this event will cause the triggering of the `:key` event; which you should define to 'do things'. If the `escape` key is pressed, then `key` is triggered with the argument `:escape`, also an internal event `_mode_switch_` is triggered.

#### `:_log_` 

When triggered with a message will cause Vedeu to log the message if logging is enabled in the configuration.

#### `:_mode_switch_`

When triggered (after the user presses `escape`), Vedeu switches from a "raw mode" terminal to a "cooked mode" terminal. The idea here being that the raw mode is for single keypress actions, whilst cooked mode allows the user to enter more elaborate commands- such as commands with arguments.

#### `:_refresh_`

Triggering this event will cause all interfaces to refresh.

#### `:_refresh_group_(group_name)_`

Will refresh all interfaces belonging to this group. E.g. `_refresh_group_home_` will refresh all interfaces with the group of `home`.

#### `:_refresh_(interface_name)_`

Will refresh the interface with this name. E.g. `_refresh_widget_` will refresh the interface `widget`.

#### `:_resize_`

When triggered will cause Vedeu to trigger the `:_clear_` and `:_refresh_`
events. Please see those events for their behaviour.


##### Notes:

System events can be handled or triggered by your application also, but overriding or adding additional events to the Vedeu system event namespace may cause unpredictable results. It is recommended to only to hook into events like :_cleanup_, :_initialize_ and :key if you need to do something respective
to those events.


... TODO ... What about events in Vedeu::Menu?

... TODO ... More information about system events.


### User Events

User events allow you to orchestrate behaviour within your application, ie. the user presses a specific key, you trigger an event to make something happen. Eg. pressing 'p' instructs the player to play.


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



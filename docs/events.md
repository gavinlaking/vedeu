## Vedeu Events

Vedeu provides an event mechanism to facilitate the functionality of your application. The events are either Vedeu defined, ie. system events or user defined, ie. user events.

Events described in this document assume that you have included Vedeu in your class:

```ruby
class SomeClassInYourApplication
  include Vedeu

  # ...
```


##### Notes:

System events can be handled or triggered by your application also, but overriding or adding additional events to the Vedeu system event namespace may cause unpredictable results. It is recommended to only to hook into events like :cleanup, :_initialize_ and :key if you need to do something respective to those events.

... TODO ... What about events in Vedeu::Menu?

... TODO ... More information about system events.


### User Events

User events allow you to orchestrate behaviour within your application, ie. the user presses a specific key, you trigger an event to make something happen. Eg. pressing 'p' instructs the player to play.

## Pre-defined User Events

Vedeu pre-defines a few user events, which client applications can listen for, or trigger themselves.

### `:_tick_`

Each time Vedeu completes one cycle in the application loop
(Application#run_many), it triggers the `:_tick_` event. This can be used by the
client application for timing amongst other things.

#### How to define user events

```ruby
bind :event_name do |arg1, arg2|
  # ...

  # Things that should happen when the event is triggered; these can be method
  # calls or the triggering of another event or events.

  # ...
end
```

... TODO ... How to define.


#### How to trigger user events

... TODO ... How to trigger.


#### More information.

... TODO ... More information about user events.



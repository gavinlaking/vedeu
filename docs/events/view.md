# @title Vedeu View Events

## View Events

Note: 'name' is a Symbol unless mentioned otherwise.

### `:\_maximise\_`
Maximising an interface.

    Vedeu.trigger(:_maximise_, name)

See {Vedeu::Geometry::Geometry#maximise}

### `:\_resize\_`
When triggered will cause Vedeu to trigger the `:_clear_` and
`:_refresh_` events. Please see those events for their behaviour.

    Vedeu.trigger(:_resize_)

### `:\_unmaximise\_`
Unmaximising an interface.

    Vedeu.trigger(:_unmaximise_, name)

See {Vedeu::Geometry::Geometry#unmaximise}

### Vedeu.bind

Register an event by name with optional delay (throttling)
which when triggered will execute the code contained within
the passed block.

@param name [Symbol] The name of the event to be triggered
  later.
@param options [Hash<Symbol => void>] The options to
  register the event with.
@option options :delay [Fixnum|Float] Limits the execution
  of the triggered event to only execute when first
  triggered, with subsequent triggering being ignored until
  the delay has expired.
@option options :debounce [Fixnum|Float] Limits the
  execution of the triggered event to only execute once the
  debounce has expired. Subsequent triggers before debounce
  expiry are ignored.
@param block [Proc] The event to be executed when triggered.
  This block could be a method call, or the triggering of
  another event, or sequence of either/both.

    Vedeu.bind :my_event do |some, args|
      # ... some code here ...
      Vedeu.trigger(:my_other_event)
    end

    T = Triggered, X = Executed, i = Ignored.
    0.0.....0.2.....0.4.....0.6.....0.8.....1.0.....1.2.....1.4.....1.6.
    .T...T...T...T...T...T...T...T...T...T...T...T...T...T...T...T...T..
    .X...i...i...i...i...X...i...i...i...i...X...i...i...i...i...i...i..

    Vedeu.bind(:my_delayed_event, { delay: 0.5 })
      # ... some code here ...
    end

    T = Triggered, X = Executed, i = Ignored.
    0.0.....0.2.....0.4.....0.6.....0.8.....1.0.....1.2.....1.4.....1.6.
    .T...T...T...T...T...T...T...T...T...T...T...T...T...T...T...T...T..
    .i...i...i...i...i...i...i...X...i...i...i...i...i...i...X...i...i..

    Vedeu.bind(:my_debounced_event, { debounce: 0.7 })
      # ... some code here ...
    end


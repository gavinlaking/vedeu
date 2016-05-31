### Vedeu.timer

Measure the execution time of the code in the given block.

The optional message provided will have ' took <time>ms.' appended and
will appear in the log file if the 'debug!' Vedeu configuration option
was given.

    Vedeu.timer 'Really complex code' do
      # ... code to be measured
    end

    # => 'Really complex code took 0.234ms.'


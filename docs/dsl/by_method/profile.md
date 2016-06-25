### Vedeu.profile

Allow debugging via the creation of stack traces courtesy of
'ruby-prof'. Will raise an exception if 'ruby-prof' is not available.

    Vedeu.profile('/tmp/vedeu_profile') do
      # ... code to profile ...
    end

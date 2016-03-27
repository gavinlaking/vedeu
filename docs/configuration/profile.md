Sets boolean to enable/disable profiling. Vedeu's default setting is
for profiling to be disabled. Using `profile!` or setting `profile` to
true will enable profiling.

Profile uses 'ruby-prof' to write a 'vedeu_profile' file to the /tmp
directory which contains a call trace of the running application.
Upon exit, this file can be examined to ascertain certain behaviours
of Vedeu. Note: On Windows systems, the log directory is determined by
the output from `Dir.tmpdir`.

Note:
Be aware that running an application with profiling enabled will
affect performance considerably.

    Vedeu.configure do
      profile!
      # ...
    end

    Vedeu.configure do
      profile false
      # ...
    end

# @title Debugging Vedeu
# Debugging Vedeu

If you are encountering a problem whilst running your client
application, using Vedeu, and have the 'pry' gem installed or
available, you can drop the following snippet into the offending area,
and hopefully be dropped into a Pry debuggging session:

    Vedeu::Terminal.cooked_mode!
    Vedeu::Terminal.open do
      Vedeu::Terminal.debugging!

      require 'pry'
      binding.pry

    end
    Vedeu::Terminal.raw_mode!


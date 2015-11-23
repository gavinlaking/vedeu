# @title Debugging Vedeu
# Debugging Vedeu

If you are encountering a problem whilst running your client
application, using Vedeu, and have the 'pry' gem installed or
available, you can drop the following snippet into the offending area,
and hopefully be dropped into a Pry debuggging session:

    Vedeu::Terminal.cooked_mode!
    Vedeu::Terminal.open do
      mouse_off   = Vedeu::EscapeSequences::Esc.string('mouse_x10_off')
      show_cursor = Vedeu::EscapeSequences::Esc.string('show_cursor')
      Vedeu::Terminal.output(mouse_off + show_cursor)

      require 'pry'
      binding.pry

    end
    Vedeu::Terminal.raw_mode!


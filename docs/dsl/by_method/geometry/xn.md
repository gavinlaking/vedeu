### xn

Specify the ending x position (column) of the interface.
This value will override `width`.

    Vedeu.geometry :some_interface do
      xn 37 # end at column 37.

      # when :other_interface changes position,
      # :some_interface will too.
      xn  { use(:other_interface).right }
      # ... some code
    end


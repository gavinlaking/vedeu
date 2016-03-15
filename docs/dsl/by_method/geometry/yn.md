### yn

Specify the ending y position (row/line) of the interface.
This value will override `height`.

    Vedeu.geometry :some_interface do
      yn 24 # end at row 24.
      # if :other_interface changes position, :some_interface
      # will too.
      yn { use(:other_interface).bottom }
      # ... some code
    end

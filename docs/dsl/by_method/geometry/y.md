### y

Specify the starting y position (row/line) of the interface.

    Vedeu.geometry :some_interface do
      y  4 # start at row 4
      # start on row/line 3, when :other_interface changes
      # position, :some_interface will too.
      y  { use(:other_interface).north }
      # ... some code
    end

### x

Specify the starting x position (column) of the interface.

    Vedeu.geometry :some_interface do
      x 7 # start on column 7.
      # start on column 8, if :other_interface changes position
      # then :some_interface will too.
      x { use(:other_interface).east }
      # ... some code
    end

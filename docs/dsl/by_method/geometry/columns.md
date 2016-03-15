### columns

Returns the width in characters for the number of columns
specified.

    Vedeu.geometry :main_interface do
      # ... some code
      width columns(9) # Vedeu.width # => 92 (for example)
                       # 92 / 12 = 7
                       # 7 * 9 = 63
                       # Therefore, width is 63 characters.
    end

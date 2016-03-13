### rows

Returns the height in characters for the number of rows
specified.

    Vedeu.geometry :main_interface do
      # ... some code
      height rows(3)  # Vedeu.height # => 38 (for example)
                      # 38 / 12 = 3
                      # 3 * 3 = 9
                      # Therefore, height is 9 characters.
    end

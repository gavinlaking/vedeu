### align_right

Providing the optional 'width' will set the interface width,
overriding any previous or calculated value for 'width'.

Aligning the view to the right within the terminal:

    # Vedeu.geometry :my_interface do
        align_right

        # ...
    # end

or...

    # Vedeu.interface :my_interface do
    #   geometry do
          align_right

          # ...
    #   end
    # end

Align this view to the right within the terminal and setting the
width to 20 columns/chars:

    # Vedeu.geometry :my_interface do
        align_right 20

        # ...
    # end

or...

    # Vedeu.interface :my_interface do
    #   geometry do
          align_right 20

    #   end
    # end

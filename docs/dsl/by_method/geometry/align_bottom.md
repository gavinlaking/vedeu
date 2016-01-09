### align_bottom

Providing the optional 'height' will set the interface height,
overriding any previous or calculated value for 'height'.

Aligning the view with the bottom of the terminal:

    # Vedeu.geometry :my_interface do
        align_bottom

        # ...
    # end

or...

    # Vedeu.interface :my_interface do
    #   geometry do
          align_bottom

          # ...
    #   end
    # end

Align this view with the bottom of the terminal and setting the
height to 20 rows/lines:

    # Vedeu.geometry :my_interface do
        align_bottom 20

        # ...
    # end

or...

    # Vedeu.interface :my_interface do
    #   geometry do
          align_bottom 20

    #   end
    # end

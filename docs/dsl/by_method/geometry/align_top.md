### align_top

Providing the optional 'height' will set the interface height,
overriding any previous or calculated value for 'height'.

Aligning the view with the top of the terminal:

    # Vedeu.geometry :my_interface do
        align_top

        # ...
    # end

or...

    # Vedeu.interface :my_interface do
    #   geometry do
          align_top

          # ...
    #   end
    # end

Align this view with the top of the terminal and setting the
height to 20 rows/lines:

    # Vedeu.geometry :my_interface do
        align_top 20

        # ...
    # end

or...

    # Vedeu.interface :my_interface do
    #   geometry do
          align_top 20

    #   end
    # end

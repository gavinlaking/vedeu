### align_middle

Providing the optional 'height' will set the interface height,
overriding any previous or calculated value for 'height'.

Aligning the view in the vertical centre of the terminal:

    # Vedeu.geometry :my_interface do
        align_middle

        # ...
    # end

or...

    # Vedeu.interface :my_interface do
    #   geometry do
          align_middle

          # ...
    #   end
    # end

Align this view in the vertical centre of the terminal and setting the
height to 20 rows/lines:

    # Vedeu.geometry :my_interface do
        align_middle 20

        # ...
    # end

or...

    # Vedeu.interface :my_interface do
    #   geometry do
          align_middle 20

    #   end
    # end

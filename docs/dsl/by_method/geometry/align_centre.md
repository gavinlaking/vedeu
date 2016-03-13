### align_centre

Providing the optional 'width' will set the interface width,
overriding any previous or calculated value for 'width'.

Aliases:
- align_center

Aligning the view centrally within the terminal:

    # Vedeu.geometry :my_interface do
        align_centre

        # ...
    # end

or...

    # Vedeu.interface :my_interface do
    #   geometry do
          align_centre

          # ...
    #   end
    # end

Align this view centrally within the terminal and setting the
width to 20 columns/chars:

    # Vedeu.geometry :my_interface do
        align_centre 20

        # ...
    # end

or...

    # Vedeu.interface :my_interface do
    #   geometry do
          align_centre 20

    #   end
    # end

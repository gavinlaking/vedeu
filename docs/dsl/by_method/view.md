### `view`

Used within a `Vedeu.renders` or `Vedeu.views` block, the `view` DSL
method defines a view for the named interface.

    # Vedeu.renders do
        view :my_interface do
          # ...
        end

        view :other_interface do
          # ...
        end
    # end

or

    # Vedeu.views do
        view :my_interface do
          # ...
        end

        view :other_interface do
          # ...
        end
    # end

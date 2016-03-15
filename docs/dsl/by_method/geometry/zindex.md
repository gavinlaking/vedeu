### zindex

Aliases:
- `z_index`
- `z`

Set the zindex of the view using this geometry. This controls
the render order of the views. Views with geometries with a
lower zindex will render before those with a higher zindex.

    # --4-- # rendered last
    # --3--
    # --2--
    # --1-- # rendered first
    Vedeu.geometry :my_interface do
      zindex 3
      # ...
    end

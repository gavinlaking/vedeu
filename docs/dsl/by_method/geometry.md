### Vedeu.geometry

Specify the geometry of an interface or view with a simple DSL.

    # Standalone (preferred):
    Vedeu.geometry :my_interface do
      # ... see {Vedeu::Geometries::DSL}
    end

Geometry can also be specified when configuring new interfaces or
views.

    # As part of an interface:
    Vedeu.interface :my_interface do
      geometry do
        # ... see {Vedeu::Geometries::DSL}
      end
    end

    # As part of a view:
    Vedeu.render do
      view :my_interface do
        geometry do
          # ... see {Vedeu::Geometries::DSL}
        end
      end
    end

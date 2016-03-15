### use

Use the attribute of stored model.

This DSL method provides access to a stored model by name.
You can then request an attribute of that model for use within
the current model. The models which current support this are
Border, Geometry and Interface.

    # Here the character used for :my_border is used in
    # :my_other_border.
    Vedeu.border :my_other_border do
      top_right use(:my_border).top_right
    end


- Only models of the same repository can be used in this
  way.
- If the stored model cannot be found, a ModelNotFound
  exception may be raised, or the request for an attribute
  may raise a NoMethodError exception.

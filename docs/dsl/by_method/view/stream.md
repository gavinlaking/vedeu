Multiple `stream` entries directly within a `view` are treated as
individual lines:

    # Vedeu.render do
    #   view(name) do

        stream do
          # ...
        end

        stream do
          # ...
        end

    #   end
    # end



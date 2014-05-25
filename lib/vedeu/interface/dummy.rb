module Vedeu
  class Dummy < Interface
    def initial_state; end

    # def input; end

    # def output; end

    private

    def options
      {
        geometry: {
          y:      1,
          x:      1,
          width:  :auto,
          height: :auto
        }
      }
    end
  end
end

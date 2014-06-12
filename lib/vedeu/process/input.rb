module Vedeu
  class Input
    class << self
      def capture
        new.capture
      end
    end

    def initialize; end

    def capture
      Terminal.input
    end
  end
end

module Vedeu
  module API
    module Helpers
      def colour(values = {})
        fail InvalidArgument, '#colour expects a Hash containing :foreground,' \
                              ' :background or both.' unless values.is_a?(Hash)

        attributes[:colour] = values
      end

      def style(values = [], &block)
        if block_given?
          attributes[:streams] << API::Stream.build({ style: [values] }, &block)

        else
          [values].flatten.each { |value| attributes[:style] << value }

        end
      end
    end
  end
end

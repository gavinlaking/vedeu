module Vedeu

  module Views

    class Buffer

      extend Forwardable

      def_delegators :view,
                     :lines,
                     :lines?

      # @param view [Vedeu::Views::View]
      # @return [Vedeu::Views::Buffer]
      def initialize(view)
        @view = view
      end

      def transform
        if view.lines.any?
          buffer_lines = []

          view.lines.each do |line|
            buffer_line = []

            if line.streams.any?
              line.streams.each do |stream|
                if stream.chars.any?
                  buffer_line << stream.chars

                else
                  buffer_line << []

                end
              end

              buffer_line

            else
              buffer_line

            end

            buffer_lines << buffer_line
          end

          buffer_lines

        else
          []

        end
      end

      protected

      # @!attribute [r] view
      # @return [Vedeu::Views::View]
      attr_reader :view

    end # Buffer

  end # Views

end # Vedeu

module Vedeu

  module Renderers

    # Writes the given output to a file.
    #
    # @api private
    class File

      # @return [String]
      # @see Vedeu::Renderers::File#initialize
      def self.render(output, options = {})
        new(output, options).render
      end

      # Returns a new instance of Vedeu::Renderers::File.
      #
      # @param output [String]
      # @param options [Hash]
      # @option options filename [String] Provide a filename for the output.
      #   Defaults to 'out'.
      # @option options timestamp [Boolean] Append a timestamp to the filename.
      # @return [Vedeu::Renderers::File]
      def initialize(output, options = {})
        @output  = output
        @options = options
      end

      # @return [String]
      def render
        ::File.open(path, 'w') { |f| f.write(parsed) }

        parsed
      end

      protected

      # @!attribute [r] output
      # @return [String]
      attr_reader :output
      alias_method :parsed, :output

      private

      # @return [String]
      def path
        "/tmp/#{filename}"
      end

      # @return [String]
      def filename
        if timestamp?
          "#{options[:filename]}_#{timestamp}"

        else
          options[:filename]

        end
      end

      # @return [Float]
      def timestamp
        @timestamp ||= Time.now.to_f
      end

      # @return [Boolean]
      def timestamp?
        return true if options[:timestamp]

        false
      end

      # @return [Hash]
      def options
        defaults.merge!(@options)
      end

      # @return [Hash]
      def defaults
        {
          filename:  'out',
          timestamp: false,
        }
      end

    end # File

  end # Renderers

end # Vedeu

module Vedeu

  module Renderers

    # Writes the given output to a file.
    #
    class File

      # Returns a new instance of Vedeu::Renderers::File.
      #
      # @param options [Hash]
      # @option options filename [String] Provide a filename for the output.
      #   Defaults to 'out'.
      # @option options timestamp [Boolean] Append a timestamp to the filename.
      # @return [Vedeu::Renderers::File]
      def initialize(options = {})
        @options = options || {}
      end

      # @param output [Array<Array<Vedeu::Views::Char>>]
      # @return [String]
      def render(output)
        ::File.write(filename, output) if write_file?

        output
      end

      private

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

      # @return [Boolean]
      def write_file?
        options[:write_file]
      end

      # Combines the options provided at instantiation with the default values.
      #
      # @return [Hash]
      def options
        defaults.merge!(@options)
      end

      # Returns the default options/attributes for this class.
      #
      # @return [Hash]
      def defaults
        {
          filename:   'out',
          timestamp:  false,
          write_file: true,
        }
      end

    end # File

  end # Renderers

end # Vedeu

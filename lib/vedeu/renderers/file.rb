# frozen_string_literal: true

module Vedeu

  module Renderers

    # Writes the given output to a file.
    #
    class File

      include Vedeu::Renderers::Options

      # Returns a new instance of Vedeu::Renderers::File.
      #
      # @param options [Hash]
      # @option options filename [String] Provide a filename for the
      #   output. Defaults to 'out'.
      # @option options timestamp [Boolean] Append a timestamp to the
      #   filename.
      # @option options write_file [Boolean] Whether to write the file
      #   to the given filename.
      # @return [Vedeu::Renderers::File]
      def initialize(options = {})
        @options = options || {}
      end

      # Render the output (either content or clearing) to a file.
      #
      # @param output [Vedeu::Models::Page]
      # @param opts [Hash]
      # @return [String]
      def render(output = '', opts = {})
        @options = options.merge!(opts)

        ::File.write(filename, out(output)) if write_file?

        out(output)
      end
      alias_method :clear, :render

      private

      # Compresses the output depending on configuration.
      #
      # @param output [Vedeu::Models::Page]
      # @return [String]
      def out(output)
        if compress?
          Vedeu::Output::Compressor.render(output, options)

        else
          output

        end
      end

      # Return the filename given in the options, (or use the
      # default), and append a timestamp if the :timestamp option was
      # set to true.
      #
      # @return [String]
      def filename
        options[:filename] + timestamp
      end

      # Return a timestamp for use as part of the filename if the
      # :timestamp option was set to true, otherwise an empty string.
      #
      # @return [Float]
      def timestamp
        if options[:timestamp]
          "_#{Vedeu.clock_time}"

        else
          ''

        end
      end

      # Returns a boolean indicating whether a file should be written.
      #
      # @return [Boolean]
      def write_file?
        options[:write_file]
      end

      # Returns the default options/attributes for this class.
      #
      # @return [Hash]
      def defaults
        {
          compression: Vedeu::Configuration.compression?,
          filename:    'out',
          timestamp:   false,
          write_file:  true,
        }
      end

    end # File

  end # Renderers

end # Vedeu

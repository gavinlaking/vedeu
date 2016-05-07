# frozen_string_literal: true

module Vedeu

  module Renderers

    # Provides shared functionality to Vedeu::Renderer classes.
    #
    module Options

      include Vedeu::Common

      # @!attribute [rw] options
      # @return [Hash<Symbol => void>]
      attr_accessor :options

      # Returns a new instance of the class including this module.
      #
      # @param opts [Hash]
      # @option opts content [String] Defaults to an empty string.
      # @option opts end_tag [String] Defaults to '</td>'.
      # @option opts end_row_tag [String] Defaults to '</tr>'.
      # @option opts filename [String] Provide a filename for the
      #   output. Defaults to 'out'.
      # @option opts start_tag [String] Defaults to '<td' (note the
      #   end of the tag is missing, this is so that inline styles can
      #   be added later).
      # @option opts start_row_tag [String] Defaults to '<tr>'.
      # @option opts template [String]
      # @option opts timestamp [Boolean] Append a timestamp to the
      #   filename.
      # @option opts write_file [Boolean] Whether to write the file
      #   to the given filename.
      # @return [void]
      def initialize(opts = {})
        @options = defaults.merge!(opts || {})
      end

      # Render a cleared output.
      #
      # @return [String]
      def clear
        render('')
      end

      # @param output [Vedeu::Models::Page]
      # @return [void]
      def render(output = '')
        options[:output] = output

        write
      end

      # @macro raise_not_implemented
      def write
        raise Vedeu::Error::NotImplemented
      end

      private

      # Returns a boolean indicating whether the content should be
      # compressed if compression is available.
      #
      # @return [Boolean]
      def compression?
        boolean(options[:compression])
      end

      # Compresses the output depending on configuration.
      #
      # @return [String]
      def compression
        if compression?
          Vedeu::Output::Compressor.render(output, options)

        else
          output

        end
      end

      # @macro raise_not_implemented
      def content
        raise Vedeu::Error::NotImplemented
      end

      # @macro defaults_method
      def defaults
        {
          compression:   Vedeu.config.compression?,
          end_tag:       '</td>',
          end_row_tag:   '</tr>',
          filename:      Dir.tmpdir + '/vedeu_out',
          output:        '',
          start_tag:     '<td',
          start_row_tag: '<tr>',
          template:      default_template,
          timestamp:     false,
          write_file:    false,
        }
      end

      # @return [String]
      def default_template
        ::File.dirname(__FILE__) + '/../templates/html_renderer.vedeu'
      end

      # @return [String]
      def end_tag
        options[:end_tag]
      end

      # @return [String]
      def end_row_tag
        options[:end_row_tag]
      end

      # Return the filename given in the options, (or use the
      # default), and append a timestamp if the :timestamp option was
      # set to true.
      #
      # @return [String]
      def filename
        options[:filename] + timestamp
      end

      # @return [String]
      def start_tag
        options[:start_tag]
      end

      # @return [String]
      def start_row_tag
        options[:start_row_tag]
      end

      # @return [Array<void>]
      def output
        options[:output]
      end

      # @return [Boolean]
      def output?
        present?(output)
      end

      # @return [String]
      def template
        options[:template]
      end

      # @return [Boolean]
      def timestamp?
        boolean(options[:timestamp])
      end

      # Return a timestamp for use as part of the filename if the
      # :timestamp option was set to true, otherwise an empty string.
      #
      # @return [String]
      def timestamp
        return "_#{Vedeu.clock_time}" if timestamp?

        ''
      end

      # Returns a boolean indicating whether a file should be written.
      #
      # @return [Boolean]
      def write_file?
        boolean(options[:write_file])
      end

      # Render the output (either content or clearing) to a file.
      #
      # @return [String]
      def write_file
        data = content

        ::File.write(filename, data)

        data
      end

    end # Options

  end # Renderers

end # Vedeu

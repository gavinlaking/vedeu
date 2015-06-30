module Vedeu

  module Renderers

    # Renders a {Vedeu::VirtualBuffer} or {Vedeu::Output} as JSON.
    #
    # @api private
    class JSON

      # @param output [Array<Array<Vedeu::Char>>]
      # @param options [Hash]
      # @return [String]
      def self.render(output, options = {})
        new(output, options).render
      end

      # @param output [Array<Array<Vedeu::Char>>]
      # @param path [String]
      # @return [String]
      # def self.to_file(output, path = nil)
      #   new(output).to_file(path)
      # end

      # Returns a new instance of Vedeu::Renderers::JSON.
      #
      # @param output [Array<Array<Vedeu::Char>>]
      # @param options [Hash]
      # @return [Vedeu::Renderers::JSON]
      def initialize(output, options = {})
        @output  = output
        @options = options
      end

      # @return [String]
      def render
        ::File.open(path, 'w') { |f| f.write(parsed) }

        parsed
      end

      # @!attribute [r] output
      # @return [Array]
      attr_reader :output

      private

      # @return [String]
      def parsed
        return '' if output.nil? || output.empty?

        ::JSON.pretty_generate(sorted)
      end

      # @return [String]
      def path
        "/tmp/#{filename}"
      end

      # @return [Array]
      def sorted
        Array(output).flatten.sort { |a, b| a.position <=> b.position }.map { |char| char.to_hash }
      end

      # @return [String]
      def filename
        if timestamp?
          "json_#{timestamp}"

        else
          'out'

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
          timestamp: false,
        }
      end

    end # JSON

  end # Renderers

end # Vedeu

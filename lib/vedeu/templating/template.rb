require 'vedeu/templating/preprocessor'

module Vedeu

  module Templating

    # Generic class to loading a template and parsing it via ERb.
    #
    # @api private
    class Template

      # @param (see Vedeu::Templating::Template#new)
      # @return [void]
      def self.parse(object, path, options = {})
        new(object, path, options).parse
      end

      # Returns a new instance of Vedeu::Templating::Template.
      #
      # @param object [Class]
      # @param path [String]
      # @param options [Hash]
      # @option options name [String] The name of an interface.
      # @return [Vedeu::Templating::Template]
      def initialize(object, path, options = {})
        @object  = object
        @path    = path.to_s
        @options = options || {}
      end

      # @return [void]
      def parse
        ERB.new(load, nil, '-').result(binding)
      end

      protected

      # @!attribute [r] object
      # @return [Class]
      attr_reader :object

      # @!attribute [r] options
      # @return [Hash]
      attr_reader :options

      private

      # @return [String]
      def preprocess
        Vedeu::Templating::Preprocessor.process(load)
      end

      # @return [String]
      def load
        File.read(path)
      end

      # @raise [MissingRequired] when the path is empty.
      # @raise [MissingRequired] when the path does not exist.
      # @return [String]
      def path
        fail MissingRequired, 'No path to template specified.' if @path.empty?

        unless File.exist?(@path)
          fail MissingRequired, "Template file cannot be found. (#{@path})"
        end

        @path
      end

    end # Template

  end # Templating

end # Vedeu

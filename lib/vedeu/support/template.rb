module Vedeu

  # Generic class to loading a template and parsing it via ERb.
  class Template

    # @param object [Class]
    # @param path [String]
    # @return [void]
    def self.parse(object, path)
      new(object, path).parse
    end

    # Returns a new instance of Vedeu::Template.
    #
    # @param object [Class]
    # @param path [String]
    # @return [Template]
    def initialize(object, path)
      @object = object
      @path   = path.to_s
    end

    # @return [void]
    def parse
      ERB.new(load, nil, '-').result(binding)
    end

    protected

    # @!attribute [r] object
    # @return [Class]
    attr_reader :object

    private

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
        fail MissingRequired, 'Template file cannot be found.'
      end

      @path
    end

  end # Template

end # Vedeu

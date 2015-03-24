module Vedeu

  # Generic class to loading a template and parsing it via ERb.
  class Template

    # include Vedeu::TemplateHelpers

    # @param see Vedeu::Template#new
    # @return [void]
    def self.parse(object, path, options = {})
      new(object, path, options).parse
    end

    # Returns a new instance of Vedeu::Template.
    #
    # @param object [Class]
    # @param path [String]
    # @param options [Hash]
    # @option options name [String] The name of an interface.
    # @return [Template]
    def initialize(object, path, options = {})
      @object  = object
      @path    = path.to_s
      @options = options
    end

    # @return [void]
    def parse
      #parse_lines

      ERB.new(load, nil, '-').result(binding)
    end

    # def parse_lines
    #   line_objects = Array(lines).map do |text_line|
    #     # # parsed        = ERB.new(text_line, nil, '-').result(binding)
    #     # stream        = Vedeu::Stream.new({ value: text_line })
    #     # line          = Vedeu::Line.new({ parent: interface, streams: stream })
    #     # Vedeu.log(type: :debug, message: "#{self.class.name}/#{__callee__}: #{line.inspect}")
    #     # stream.parent = line
    #     # line.add(stream)
    #     # line
    #   end
    #   new_lines = Vedeu::Lines.new(line_objects)
    # end

    protected

    # @!attribute [r] object
    # @return [Class]
    attr_reader :object

    # @!attribute [r] options
    # @return [Hash]
    attr_reader :options

    private

    # def interface
    #   if interface_name && Vedeu.interfaces.registered(interface_name)
    #     Vedeu.interfaces.find(interface_name)
    #   end
    # end

    # def interface_name
    #   options[:name]
    # end

    # # @return [Array<String>]
    # def lines
    #   File.readlines(path)
    # end

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

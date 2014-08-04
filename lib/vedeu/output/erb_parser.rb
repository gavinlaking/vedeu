require 'erb'
require 'vedeu/support/helpers'
require 'vedeu/output/text_adaptor'

module Vedeu
  class ERBParser
    include Helpers

    def self.parse(object)
      new(object).parse
    end

    def initialize(object)
      @object = object
      @output = ''
    end

    def parse
      {
        interfaces: [
          {
            name:  interface,
            lines: TextAdaptor.adapt(erb_output)
          }
        ]
      }
    end

    private

    attr_reader :object

    def capture(&block)
      erbout = eval('_erbout', block.binding)
      erbout_length = erbout.length
      block.call
      erbout_addition = erbout[erbout_length..-1]
      erbout[erbout_length..-1] = ''
      erbout_addition = erbout_addition.join if erbout_addition.is_a? Array
      erbout_addition
    end

    def erb_output
      ERB.new(template, nil, '-').result(get_binding)
    end

    def interface
      object.interface
    end

    def template
      File.read(object.path)
    end

    def get_binding
      object.send(:binding)
    end
  end
end

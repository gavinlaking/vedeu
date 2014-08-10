require 'vedeu/api/line'
require 'vedeu/api/store'

module Vedeu
  module API
    InterfaceNotSpecified = Class.new(StandardError)

    def render(object = nil)
      Vedeu::View.render(object)
    end

    def view(name = '', &block)
      Vedeu::API::View.build(name, &block)
    end

    class View
      def self.build(name = '', &block)
        new(name).build(&block)
      end

      def initialize(name = '')
        fail Vedeu::API::InterfaceNotSpecified if name.nil? || name.empty?

        @name = name.to_s
      end

      def build(&block)
        @self_before_instance_eval = eval 'self', block.binding

        self.instance_eval(&block) if block_given?

        attributes
      end

      def line(&block)
        attributes[:lines] << API::Line.build(&block)
      end

      def attributes
        @_attributes ||= { name: name, lines: [] }
      end

      def name
        return @name if Store.query(@name)
      end

      # :nocov:
      def method_missing(method, *args, &block)
        @self_before_instance_eval.send method, *args, &block
      end
      # :nocov
    end
  end
end

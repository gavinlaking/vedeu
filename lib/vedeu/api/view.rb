require 'vedeu/api/base'
require 'vedeu/api/line'
require 'vedeu/support/interface_store'

module Vedeu
  module API
    InterfaceNotSpecified = Class.new(StandardError)

    class View
      def self.build(name = '', &block)
        new(name).build(&block)
      end

      def initialize(name = '')
        fail Vedeu::API::InterfaceNotSpecified if name.nil? || name.empty?

        @name = name.to_s
      end

      def build(&block)
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
        return @name if InterfaceStore.query(@name)
      end
    end
  end
end

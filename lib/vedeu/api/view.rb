module Vedeu
  module API
    InterfaceNotSpecified = Class.new(StandardError)

    class View
      def self.build(name, &block)
        new(name).build(&block)
      end

      def initialize(name)
        fail InterfaceNotSpecified if name.nil? || name.empty?

        @name = name.to_s
      end

      def build(&block)
        if block_given?
          @self_before_instance_eval = eval('self', block.binding)

          instance_eval(&block)
        end

        attributes
      end

      def line(&block)
        attributes[:lines] << Line.build(&block)
      end

      def attributes
        @_attributes ||= { name: name, lines: [] }
      end

      def name
        return @name if Store.query(@name)
      end

      private

      def method_missing(method, *args, &block)
        @self_before_instance_eval.send method, *args, &block
      end
    end
  end
end

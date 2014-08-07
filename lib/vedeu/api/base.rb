module Vedeu
  module API
    class Base
      def self.build(attributes = {}, &block)
        new(attributes, &block).build
      end

      def initialize(attributes, &block)
        @attributes = attributes

        @self_before_instance_eval = eval 'self', block.binding

        self.instance_eval(&block)
      end

      def colour(*args)
        if args.is_a?(Array) && args.size == 2
          attributes[:colour] = { background: args.first,
                                  foreground: args.last }

        elsif args.is_a?(Array) && args.size == 1 && args.first.is_a?(Hash)
          attributes[:colour] = args.first

        else
          attributes[:colour] = {}

        end
      end

      def style(values = [], &block)
        if block_given?
          attributes[:streams] << API::Stream.build({ style: [values] }, &block)
        else
          [values].flatten.each { |value| attributes[:style] << value }
        end
      end

      # :nocov:
      def method_missing(method, *args, &block)
        @self_before_instance_eval.send method, *args, &block
      end
      # :nocov
    end
  end
end

module Vedeu
  module API
    InterfaceNotSpecified = Class.new(StandardError)

    class Interface # < View (not sure...)
      def self.build(&block)
        new.build(&block)
      end

      def initialize; end

      def build(&block)
        self.instance_eval(&block) if block_given?

        attributes.delete_if { |k, v| v.nil? || v.empty? }
      end

      #private

      def colour(*args)
        attributes[:colour] = {}
      end

      def foreground(value = '')
        attributes[:colour][:foreground] = value
      end

      def background(value = '')
        attributes[:colour][:background] = value
      end

      def style(values = [])
        [values].flatten.each { |value| attributes[:style] << value }
      end

      def attributes
        @attributes ||= { lines: [], colour: {}, style: [] }
      end
    end

    class Line < Interface
      # private

      def width(value)
        # Stream...
      end

      def align(value)
        # Stream...
      end

      def stream(&block)
        API::Stream.build(&block)
      end

      def text(value)
        attributes[:lines] << { streams: [{ text: value }] }
      end
    end

    class Stream < Line
      # private

      def text(value)
        { text: value }
      end
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
        self.instance_eval(&block) if block_given?

        attributes
      end

      private

      def line(&block)
        attributes.merge!(API::Line.build(&block))
      end

      def attributes
        @_attributes ||= { name: name }
      end

      def name
        return @name if InterfaceStore.query(@name)
      end
    end
  end
end

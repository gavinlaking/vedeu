module Vedeu
  module Interface
    module ClassMethods; end

    module InstanceMethods
      def initialize(options = {})
        @options = options
      end

      def run
        output

        input
      end

      def input
        Vedeu::Terminal.show_cursor
      end

      def output
        Vedeu::Terminal.hide_cursor

        #1.upto(height) { print "\n" }
      end

      def width
        options[:width]  || Vedeu::Terminal.width
      end

      def height
        options[:height] || Vedeu::Terminal.height
      end

      private

      attr_reader :options
    end

    def self.included(receiver)
      receiver.extend(ClassMethods)
      receiver.send(:include, InstanceMethods)
    end
  end
end

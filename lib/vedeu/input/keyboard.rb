module Vedeu
  module Input
    class Keyboard
      class << self
        def capture(options = {})
          new(options).capture
        end
      end

      def initialize(options = {})
        @options = options
      end

      def capture
        Clock.start(seconds: sequence_timeout) do
          key = Vedeu::Terminal.input

          return parse if key == nil
          sequence << key
        end
      rescue OutOfTimeError
        parse
        reset
        capture
      end

      private

      def parse
        Input::Parser.parse(sequence) if sequence.any?
      end

      def reset
        @sequence = []
      end

      def sequence
        @sequence ||= []
      end

      def sequence_timeout
        options.fetch(:sequence_timeout)
      end

      def options
        defaults.merge!(@options)
      end

      def defaults
        { sequence_timeout: 0.005 }
      end
    end
  end
end

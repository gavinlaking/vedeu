module Vedeu
  module Input
    class Parser
      def self.parse(stream)
        new(stream).parse
      end

      def initialize(stream)
        @stream = stream
      end

      def parse
        if needs_paste_fix?
          [standard_parse]
        elsif escape_sequence?
          [Input::Translator.press(stringified_standard_parse)]
        else
          multibyte_parse
        end
      end

      private

      attr_reader :stream

      def standard_parse
        Input::Character::Standard.parse(stream)
      end

      def stringified_standard_parse
        standard_parse.sub(/\e+/,'^').sub('[[','[')
      end

      def multibyte_parse
        Input::Character::Multibyte.parse(stream)
      end

      def needs_paste_fix?
        stream.size > 1 && return_pressed?
      end

      def escape_sequence?
        escape_pressed? && stream.size.between?(2, 7)
      end

      def return_pressed?
        stream.include?(13)
      end

      def escape_pressed?
        stream.first == 27
      end
    end
  end
end

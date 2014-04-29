module Vedeu
  module Input
    module Character
      class Multibyte
        def self.parse(stream)
          new(stream).parse
        end

        def initialize(stream)
          @stream = stream
        end

        def parse
          stream.each do |character|
            if character.between?(128, 255)
              collection << character
            else
              process_collection
              parsed << Input::Translator.press(character)
            end
          end

          process_collection
          parsed
        end

        private

        attr_reader :stream

        def process_collection
          if collection.any?
            parsed << Standard.parse(collection)
            reset_collection
          end
        end

        def reset_collection
          @collection = []
        end

        def collection
          @collection ||= []
        end

        def parsed
          @parsed ||= []
        end
      end
    end
  end
end

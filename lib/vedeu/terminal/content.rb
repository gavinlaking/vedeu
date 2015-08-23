module Vedeu

  module Terminal

    # A permanent copy of the terminal output.
    #
    module Content

      include Vedeu::Common
      extend self

      # @param char [Vedeu::Views::Char]
      # @return [Boolean]
      def valid?(char)
        char.respond_to?(:position) &&
          present?(char.position.y) &&
          present?(char.position.x)
      end

      # @param char [Vedeu::Views::Char]
      # @return [Vedeu::Views::Char]
      def store(char)
        # value = {}
        # value[:background] = char.background.to_s if char.background
        # value[:foreground] = char.foreground.to_s if char.foreground
        # value[:style]      = char.style.to_s      if char.style
        # value[:value]      = char.value           if char.value
        # value[:x]          = char.position.x      if char.position.x
        # value[:y]          = char.position.y      if char.position.y

        storage[char.position.y][char.position.x] = char.value if valid?(char)

        char
      end

      # @param chars [Array<Vedeu::Views::Char>]
      # @return [Array<Vedeu::Views::Char>]
      def stores(chars)
        Array(chars).flatten.map { |char| store(char) }
      end

      # @return [Hash<String => String>|NilClass]
      def write
        filename = "/tmp/vedeu/content_#{Time.now.to_f}"

        File.write(filename, storage.inspect) if Vedeu::Configuration.log?
      end

      # @return [Array<String>]
      def reprocess
        out = []
        storage.each do |y, line|
          line.each do |x, value|
            out << Vedeu::Views::Char.new(position: [y, x], value: value).to_s
          end
        end

        Vedeu::Terminal.clear

        Vedeu::Terminal.output(out.join)
      end

      # @return [Hash]
      def reset
        @storage = in_memory
      end

      private

      # Returns an empty collection ready for the storing terminal content.
      #
      # @return [Hash]
      def in_memory
        Hash.new { |h, k| h[k] = {} }
      end

      # Access to the storage for this repository.
      #
      # @return [Array]
      def storage
        @storage ||= in_memory
      end

    end # Content

  end # Terminal

end # Vedeu

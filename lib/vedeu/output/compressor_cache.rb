# frozen_string_literal: true

module Vedeu

  module Output

    # Store a copy of the data last processed by
    # {Vedeu::Output::Compressor}. Both the original content and the
    # compressed versions are kept (unless modified) to speed up the
    # rendering of the display.
    #
    # @api private
    #
    module CompressorCache

      extend self
      extend Vedeu::Repositories::Storage

      # @param content [Array<void>]
      # @param compression [Boolean]
      # @return [String]
      def cache(content, compression = false)
        write(content, compression) unless empty?(content) || cached?(content)

        compression ? read(:compress) : read(:uncompress)
      end

      private

      # @param content [Array<void>]
      # @return [Boolean]
      def cached?(content)
        size?(content) && same?(content)
      end

      # @param content [Array<void>]
      # @return [Boolean]
      def size?(content)
        content.size == read(:original).size
      end

      # @param content [Array<void>]
      # @return [Boolean]
      def same?(content)
        content == read(:original)
      end

      # @param content [Array<void>]
      # @return [String]
      def compress(content)
        Vedeu::Output::Compressors::Character.with(content)
      end

      # @param content [Array<void>]
      # @return [Boolean]
      def empty?(content)
        content.nil? || content.empty?
      end

      # @return [Hash<Symbol => Array<void>, String>]
      def in_memory
        {
          compress:   '',
          original:   [],
          uncompress: '',
        }
      end

      # @param key [NilClass|Symbol]
      # @return [Array<void>]
      def read(key)
        storage.fetch(key, [])
      end

      # @param content [Array<void>]
      # @return [String]
      def uncompress(content)
        Vedeu::Output::Compressors::Simple.with(content)
      end

      # @param content [Array<void>]
      # @param compression [Boolean]
      # @return [Hash<Symbol => Array<void>>]
      def write(content, compression)
        storage[:original] = content

        if compression
          storage[:compress] = compress(content)

        else
          storage[:uncompress] = uncompress(content)

        end
      end

    end # CompressorCache

  end # Output

end # Vedeu

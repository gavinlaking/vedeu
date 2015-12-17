module Vedeu

  module DSL

    # Manipulates text values based on given options when building
    # views.
    #
    # @api private
    #
    class Text

      extend Forwardable

      def_delegators :align,
                     :centre_aligned?,
                     :left_aligned?,
                     :right_aligned?,
                     :unaligned?

      # @param value [String]
      # @param options [Vedeu::DSL::ViewOptions]
      # @return [Vedeu::DSL::Text]
      def initialize(value = '', options = Vedeu::DSL::ViewOptions.coerce({}))
        fail Vedeu::Error::Fatal unless options.is_a?(Vedeu::DSL::ViewOptions)

        @value   = value || ''
        @options = options
      end

      # def align
      #   options[:align]
      # end

      # def alignment
      #   # Vedeu::DSL::Align.new(value, options)

      #   if truncate?

      #   end
      # end

      # def truncate?
      #   options[:truncate]
      # end

      # def truncate
      #   return Vedeu::DSL::Truncate.new(value, options) if truncate?

      #   value
      # end

      # def wordwrap
      #   if truncate?
      #     value

      #   # else
      #     # wordwrap

      #   end
      # end

    end # Text

  end # DSL

end # Vedeu

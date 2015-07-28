module Vedeu

  module Templating

    # Extend Template to provide client application view specific parsing.
    #
    class ViewTemplate < Template

      include Vedeu::Templating::ViewHelpers

      # @return [Vedeu::Lines]
      def parse
        Vedeu::Templating::PostProcessor.process(erb)
      end

      protected

      # @!attribute [r] object
      # @return [Class]
      attr_reader :object

      # @!attribute [r] options
      # @return [Hash]
      attr_reader :options

      private

      # @return [String]
      def erb
        ERB.new(load, nil, '-').result(binding)
      end

    end # ViewTemplate

  end # Templating

end # Vedeu

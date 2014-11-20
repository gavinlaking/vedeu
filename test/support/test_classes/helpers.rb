module Vedeu

  module API

    class HelpersTestClass

      include Helpers

      attr_accessor :attributes

      def initialize
        @attributes = { colour: {}, streams: [], style: [] }
      end

    end # HelpersTestClass

  end # API

end # Vedeu

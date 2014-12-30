require 'vedeu/support/common'

module Vedeu

  module DSL

    class Builder

      include Vedeu::Common

      def self.build(&block)
        new.build(&block)
      end

      def initialize
      end

      def build(&block)
        return requires_block(__callee__) unless block_given?

        instance_eval(&block)
      end

    end # Builder

  end # DSL

end # Vedeu

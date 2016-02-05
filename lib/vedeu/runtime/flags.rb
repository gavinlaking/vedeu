# frozen_string_literal: true

module Vedeu

  module Runtime

    # Home of various runtime flags which Vedeu uses.
    #
    # @api private
    #
    class Flags

      include Singleton

      class << self

        # @return [Boolean]
        def ready!
          Vedeu.log(message: 'Vedeu ready!')

          instance.options[:ready] = true
        end

        # @return [Boolean]
        def ready?
          instance.options[:ready]
        end

        # Reset the flags to the default values.
        #
        # @return [Hash]
        def reset!
          instance.reset!
        end
        alias reset reset!

      end # Eigenclass

      # @!attribute [rw]
      # @return [Hash]
      attr_accessor :options

      # Create a new singleton instance of Vedeu::Runtime::Flags.
      #
      # @return [Vedeu::Runtime::Flags]
      def initialize
        self.options = defaults
      end

      # @return [Hash]
      def reset!
        self.options = defaults
      end
      alias reset reset!

      private

      # @macro defaults_method
      def defaults
        {
          ready: false,
        }
      end

    end # Flags

  end # Runtime

  # Manipulate the internal flags.
  #
  # @api public
  # @!method ready?
  #   @see Vedeu::Runtime::Flags#ready?
  # @api public
  # @!method ready!
  #   @see Vedeu::Runtime::Flags#ready!
  # @return [Boolean]
  def_delegators Vedeu::Runtime::Flags,
                 :ready?,
                 :ready!

  # :nocov:

  # See {file:docs/events/system.md#\_initialize_}
  Vedeu.bind(:_initialize_) { Vedeu.ready! }

  # :nocov:

end # Vedeu

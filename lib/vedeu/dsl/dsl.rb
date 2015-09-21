module Vedeu

  # Provides a mechanism to help configure and use Vedeu.
  #
  module DSL

    protected

    # @!attribute [r] client
    # @return [Object] The object instance where the DSL is being
    #   used.
    attr_reader :client

    # @!attribute [r] model
    # @return [void] The new model object which the DSL is
    #   constructing.
    attr_reader :model

    private

    # Returns the default attributes for the new model.
    #
    # @note
    #   Specific DSL classes may be overriding this method.
    #
    # @return [Hash<Symbol => void>]
    def attributes
      {
        client: client,
        parent: model,
      }
    end

    # :nocov:
    # Attempts to find the missing method on the client object.
    #
    # @param method [Symbol] The name of the method sought.
    # @param args [Array] The arguments which the method was to be
    #   invoked with.
    # @param block [Proc] The optional block provided to the method.
    # @return [void]
    def method_missing(method, *args, &block)
      Vedeu.log(type:    :debug,
                message: "!!!method_missing '#{method}' (#{client.inspect})")

      client.send(method, *args, &block) if client
    end
    # :nocov:

  end # DSL

end # Vedeu

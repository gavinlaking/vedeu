module Vedeu

  # Provides a mechanism to help configure and use Vedeu.
  #
  # @api public
  module DSL

    private

    # :nocov:
    # Attempts to find the missing method on the client object.
    #
    # @param method [Symbol] The name of the method sought.
    # @param args [Array] The arguments which the method was to be invoked with.
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

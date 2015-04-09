require 'vedeu/dsl/components/all'
require 'vedeu/dsl/shared/all'

require_relative 'composition'
require_relative 'group'
require_relative 'interface'
require_relative 'line'
require_relative 'stream'
require_relative 'view'

module Vedeu

  # Provides a mechanism to help configure and use Vedeu.
  #
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
      Vedeu.log(type: :debug, message: "!!!method_missing '#{method}'")

      client.send(method, *args, &block) if client
    end
    # :nocov:

  end # DSL

end # Vedeu

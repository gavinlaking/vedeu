require 'vedeu/dsl/components/all'
require 'vedeu/dsl/shared/all'

require 'vedeu/dsl/composition'
require 'vedeu/dsl/interface'
require 'vedeu/dsl/line'
require 'vedeu/dsl/stream'
require 'vedeu/dsl/view'

module Vedeu

  module DSL

    # @param method [Symbol] The name of the method sought.
    # @param args [Array] The arguments which the method was to be invoked with.
    # @param block [Proc] The optional block provided to the method.
    # @return []
    def method_missing(method, *args, &block)
      Vedeu.log("!!!method_missing '#{method}' (args: #{args.inspect})")

      client.send(method, *args, &block) if client
    end

  end # DSL

end # Vedeu

# frozen_string_literal: true

module Vedeu

  # Provides a mechanism to help configure and use Vedeu.
  #
  module DSL

    # Returns a new instance of the DSL class including {Vedeu::DSL}.
    #
    # @param model [void] The model class which the DSL class is
    #   wrapping.
    # @param client [void] The class where the DSL methods are being
    #   used.
    # @return [void] An instance of the DSL class.
    def initialize(model, client = nil)
      @model  = model
      @client = client
    end

    # Returns the model name if available.
    #
    # @return [NilClass|String|Symbol]
    def name
      return nil unless model

      model.name
    end

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
    # @macro param_block
    # @return [void]
    def method_missing(method, *args, &block)
      Vedeu.log(type:    :debug,
                message: "!!!method_missing '#{method}' sending to " \
                         "#{client.inspect}")

      client.send(method, *args, &block) if client
    end

    # :nocov:

  end # DSL

end # Vedeu

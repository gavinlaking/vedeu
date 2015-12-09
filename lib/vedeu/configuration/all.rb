module Vedeu

  # Namespace for configuration classes.
  #
  module Config

    module_function

    # Custom log for configuration.
    #
    # @param from [String] Which configuration set the options.
    # @param options [Hash<Symbol => void>] The configuration options set.
    # @return [Hash<Symbol => void>] The options param.
    def log(from, options)
      options.each do |option, value|
        Vedeu.log(type:    :config,
                  message: "#{from} #{option}: #{value}".freeze)
      end
    end

  end # Config

end # Vedeu

require 'vedeu/configuration/api'
require 'vedeu/configuration/configuration'

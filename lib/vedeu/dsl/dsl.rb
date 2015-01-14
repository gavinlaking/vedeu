module Vedeu

  # Provide a user-friendly interface to configure and use Vedeu.
  #
  module DSL

    # Build models using a simple DSL when a block is given, otherwise returns a
    # new instance of the class including this module.
    #
    # @param attributes [Hash]
    # @param block [Proc]
    # @return [Class]
    def build(attributes = {}, &block)
      model = self.new(attributes)
      model.deputy.instance_eval(&block) if block_given?
      model
    end

  end # DSL

end # Vedeu

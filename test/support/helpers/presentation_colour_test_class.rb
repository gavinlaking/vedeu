# frozen_string_literal: true

module Vedeu

  class ParentPresentationColourTestClass

    include Vedeu::Presentation

    attr_reader :colour

    def initialize
      @colour = { background: '#330000', foreground: '#00aadd' }
      @parent = nil
    end

  end # ParentPresentationColourTestClass

  class PresentationColourTestClass

    include Vedeu::Presentation

    attr_reader :parent

    def initialize(attributes = {})
      @colour = attributes[:colour]
      @parent = attributes[:parent]
    end

  end # PresentationTestClass

end # Vedeu

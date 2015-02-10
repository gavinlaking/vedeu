module Vedeu

  class PresentationTestClass

    include Presentation

    def attributes
      {
        colour: { background: '#000033', foreground: '#aadd00' },
        style:  ['bold']
      }
    end

  end # PresentationTestClass

end # Vedeu

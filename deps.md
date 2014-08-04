----------------------------------------------------------------------
By class
----------------------------------------------------------------------

Application
  Input
  Process
  Terminal

ClearInterface

Collection

Colour
  Esc

Composition
  InterfaceCollection

Configuration

Geometry
  Esc
  Terminal

ERBParser

Esc
  ColourTranslator

Events

RawParser
  TextAdaptor

Input
  Queue
  Terminal

Interface
  ClearInterface
  Colour
  Geometry
  LineCollection
  Queue
  RenderInterface
  Style
  Terminal

InterfaceCollection
  InterfaceStore

InterfaceTemplate
  Geometry
  Interface
  InterfaceStore

JSONParser

Launcher
  Application
  Configuration

Line
  Colour
  StreamCollection
  Style

LineCollection
  Collection
  Line

Menu

MenuParser

Parser
  Composition
  ERBParser
  RawParser
  JSONParser
  MenuParser

InterfaceStore
  Interface

Process
  Parser
  Queue

Queue

RenderInterface
  ClearInterface

Stream
  Colour
  Style

StreamCollection
  Collection
  Stream

Style
  Esc

Template
  Helpers

Terminal
  Esc
  Application

TextAdaptor

ColourTranslator

Wordwrap


----------------------------------------------------------------------
Orphans
----------------------------------------------------------------------

Wordwrap - orphaned
Menu     - orphaned

----------------------------------------------------------------------
Grouped
----------------------------------------------------------------------

InterfaceTemplate
  Interface
  Geometry
  InterfaceStore

Launcher
  Application
    Input
      Queue
      Terminal
        Esc
          ColourTranslator
    Process
      Parser
        Composition
          InterfaceCollection
            InterfaceStore
              Interface
                ClearInterface
                Colour
                  Esc
                    ColourTranslator
                Geometry
                  Esc
                    ColourTranslator
                  Terminal
                    Esc
                      ColourTranslator
                LineCollection
                  Collection
                  Line
                    Colour
                      Esc
                        ColourTranslator
                    StreamCollection
                      Collection
                      Stream
                        Colour
                          Esc
                            ColourTranslator
                        Style
                          Esc
                            ColourTranslator
                    Style
                      Esc
                        ColourTranslator

                Queue
                RenderInterface
                  ClearInterface
                Style
                  Esc
                    ColourTranslator
                Terminal
                  Esc
                    ColourTranslator
        ERBParser
          Template
        RawParser
          TextAdaptor
        JSONParser
        MenuParser
      Queue
    Terminal
      Esc
        ColourTranslator
  Configuration

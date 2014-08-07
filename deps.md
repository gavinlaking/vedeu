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

Esc
  ColourTranslator

Events

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

API::Interface
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

InterfaceStore
  Interface

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

Terminal
  Esc
  Application

TextAdaptor

View
  Composition
  DSLParser
  JSONParser

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

API::Interface
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
        JSONParser
      Queue
    Terminal
      Esc
        ColourTranslator
  Configuration

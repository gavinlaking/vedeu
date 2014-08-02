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
  Translator

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

Translator

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
          Translator
    Process
      Parser
        Composition
          InterfaceCollection
            InterfaceStore
              Interface
                ClearInterface
                Colour
                  Esc
                    Translator
                Geometry
                  Esc
                    Translator
                  Terminal
                    Esc
                      Translator
                LineCollection
                  Collection
                  Line
                    Colour
                      Esc
                        Translator
                    StreamCollection
                      Collection
                      Stream
                        Colour
                          Esc
                            Translator
                        Style
                          Esc
                            Translator
                    Style
                      Esc
                        Translator

                Queue
                RenderInterface
                  ClearInterface
                Style
                  Esc
                    Translator
                Terminal
                  Esc
                    Translator
        ERBParser
          Template
        RawParser
          TextAdaptor
        JSONParser
        MenuParser
      Queue
    Terminal
      Esc
        Translator
  Configuration

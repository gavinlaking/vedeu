----------------------------------------------------------------------
By class
----------------------------------------------------------------------

Application
  Input
  Process
  Terminal

Builder
  Geometry
  Interface
  Persistence

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

HashParser
  TextAdaptor

Input
  Queue
  Terminal

Interface
  ClearInterface
  Geometry
  LineCollection
  Presentation
  Queue
  RenderInterface
  Style
  Terminal

InterfaceCollection
  Persistence

JSONParser

Launcher
  Application
  Configuration

Line
  Presentation
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
  HashParser
  JSONParser
  MenuParser

Persistence
  Interface

Presentation
  Colour

Process
  Parser
  Queue

Queue

RenderInterface
  ClearInterface

Stream
  Presentation
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

Builder
  Interface
  Geometry
  Persistence

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
            Persistence
              Interface
                ClearInterface
                Geometry
                  Esc
                    Translator
                  Terminal
                    Esc
                      Translator
                LineCollection
                  Collection
                  Line
                    Presentation
                      Colour
                        Esc
                          Translator
                    StreamCollection
                      Collection
                      Stream
                        Presentation
                          Colour
                            Esc
                              Translator
                        Style
                          Esc
                            Translator
                    Style
                      Esc
                        Translator
                Presentation
                  Colour
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
        HashParser
          TextAdaptor
        JSONParser
        MenuParser
      Queue
    Terminal
      Esc
        Translator
  Configuration

----------------------------------------------------------------------
By class
----------------------------------------------------------------------

Application
  Input
  Output
  Process
  Terminal

Builder

ClearInterface

Collection

Colour
  Esc

Command

CommandBuilder
  Builder
  Repositories::CommandRepository

Repositories::CommandRepository
  Command
  Repositories::Repository

Composition
  InterfaceCollection

Compositor
  Composition

Configuration

Geometry
  Esc
  Terminal

Esc
  Translator

Events

Exit

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

InterfaceBuilder
  Builder
  Geometry
  Repositories::InterfaceRepository

InterfaceCollection
  Repositories::InterfaceRepository

Repositories::InterfaceRepository
  Interface
  Repositories::Repository

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

Output
  Repositories::InterfaceRepository
  Terminal

Parser
  Compositor
  HashParser
  JSONParser

Presentation
  Colour

Process
  Repositories::CommandRepository
  Parser
  Queue

Queue

RenderInterface
  ClearInterface

Repositories::Repository
  Repositories::Storage

Repositories::Storage

Stream
  Presentation
  Style

StreamCollection
  Collection
  Stream

Style
  Esc

Template

Terminal
  Esc
  Application

TextAdaptor

Translator

Wordwrap


----------------------------------------------------------------------
Orphans
----------------------------------------------------------------------

Template - orphaned
Wordwrap - orphaned
Menu     - orphaned
Exit     - orphaned

----------------------------------------------------------------------
Grouped
----------------------------------------------------------------------

CommandBuilder
  Builder

InterfaceBuilder
  Builder
  Geometry
  Repositories::InterfaceRepository

Launcher
  Application
    Input
      Queue
      Terminal
        Esc
          Translator
    Output
      Repositories::InterfaceRepository
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
        Repositories::Repository
          Repositories::Storage
      Terminal
        Esc
          Translator
    Process
      Repositories::CommandRepository
        Command
        Repositories::Repository
          Repositories::Storage
      Parser
        Compositor
          Composition
            InterfaceCollection
              Repositories::InterfaceRepository
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
                Repositories::Repository
                  Repositories::Storage
        HashParser
          TextAdaptor
        JSONParser
      Queue
    Terminal
      Esc
        Translator
  Configuration

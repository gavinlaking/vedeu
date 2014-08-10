----------------------------------------------------------------------
By class
----------------------------------------------------------------------

StandardError
  API::InterfaceNotSpecified
  EntityNotFound
  InvalidHeight
  InvalidWidth
  ModeSwitch
  OutOfRange
  XOutOfBounds
  YOutOfBounds

API::Base
  API::Stream

API::Grid
  Terminal

API::Interface
  API::Grid
  Geometry
  Interface
  API::Store
  Terminal

API::Line
  API::Base
  API::Stream

API::Stream
  API::Base

API::View
  API::Line
  API::Store

Application
  Input
  Terminal

Clear

Collection

Colour
  Background
    ColourTranslator
  Foreground
    ColourTranslator

Composition
  InterfaceCollection

Configuration

DSLParser

Geometry
  Esc
  Terminal

Esc

API::Events

Input
  API::Events
  Terminal

Instrumentation
  Log
  Trace

Interface
  Clear
  Colour
  Geometry
  LineCollection
  Render
  Style
  Terminal

InterfaceCollection
  API::Store

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
  API::Events

API::Store
  Interface

Render
  Line
  Stream

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

ColourTranslator

Wordwrap


----------------------------------------------------------------------
Grouped
----------------------------------------------------------------------

API::Interface
  Interface
  Geometry
  API::Store

Launcher
  Application
    Events
    Input
      Events
      Terminal
        Esc
  Configuration

View
  Composition
    InterfaceCollection
      API::Store
        Interface
          Clear
          Colour
            Background
            Foreground
          Geometry
            Esc
            Terminal
              Esc
          LineCollection
            Collection
            Line
              Colour
                Background
                Foreground
              StreamCollection
                Collection
                Stream
                  Colour
                    Background
                    Foreground
                  Style
                    Esc
              Style
                Esc
          Render
            Line
            Stream
          Style
            Esc
          Terminal
            Esc
  DSLParser

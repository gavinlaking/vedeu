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
  InterfaceStore
  Terminal

API::Line
  API::Base
  API::Stream

API::Stream
  API::Base

API::View
  API::Line
  InterfaceStore

Application
  Input
  Terminal

ClearInterface

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

Events

Input
  Events
  Terminal

Instrumentation
  Log
  Trace

Interface
  ClearInterface
  Colour
  Geometry
  LineCollection
  RenderInterface
  Style
  Terminal

InterfaceCollection
  InterfaceStore

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
  Events

InterfaceStore
  Interface

RenderInterface
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
  InterfaceStore

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
      InterfaceStore
        Interface
          ClearInterface
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
          RenderInterface
            Line
            Stream
          Style
            Esc
          Terminal
            Esc
  DSLParser

[![Code Climate](https://codeclimate.com/github/gavinlaking/vedeu.png)](https://codeclimate.com/github/gavinlaking/vedeu)

# Vedeu

Vedeu is my attempt at creating a terminal based application framework without the need for Ncurses.

## Installation

Add this line to your application's Gemfile:

    gem 'vedeu'

And then execute:

    $ bundle

## Usage

TODO: Write detailed documentation

## Notes

    Launcher
      |-- Application
            |-- EventLoop
            |     |-- Input
            |     |     |-- Queue
            |     |     |-- Terminal
            |     |
            |     |-- Process
            |     |     |-- CommandRepository
            |     |     |-- Queue
            |     |
            |     |-- Output
            |           |-- Compositor
            |           |
            |           |-- Directive
            |           |     |-- Colour
            |           |     |     |-- Background < Base
            |           |     |     |-- Foreground < Base
            |           |     |
            |           |     |-- Position
            |           |     |     |-- Esc
            |           |     |
            |           |     |-- Style
            |           |     |     |-- Cursor
            |           |     |     |-- Esc
            |           |     |
            |           |     |-- Wordwrap
            |           |
            |           |-- InterfaceRepository
            |           |-- Position
            |                 |-- Esc
            |
            |-- InterfaceRepository
            |-- Terminal

    Base
      |-- Esc
      |-- Translator

    Command
      |-- CommandRepository

    Exit

    Interface
      |-- Colour
      |     |-- Background < Base
      |     |-- Foreground < Base
      |
      |-- Geometry
      |     |-- Terminal
      |
      |-- InterfaceRepository

    Repository
      |-- Storage

    Terminal
      |-- Cursor
      |-- Esc
      |-- Position
            |-- Esc

### On Interfaces

When we create the interface we define it's width, height, and origin (y, x).
These numbers are based on the area available to the terminal. If the terminal is 80x25, then our interface can use all or some of this area.

### On Composition

To compose data suitable for output in Vedeu, you can use this EBNF. Diagrams are available in the `documentation` directory.

    Output ::= (('{' (Interface '=>' Stream) '}' (',' | ))* | ('[' (Stream (',' | ))* ']' (',' | ))* | ('[' (String (',' | ))* ']') (',' | ))*
    Stream ::= ('[' (Directive (',' | ) | String (',' | ))* ']' (',' | ))*
    Interface ::= String
    Directive ::= PositionDirective | ColourDirective | StyleDirective
    PositionDirective ::= '[' Fixnum ',' Fixnum ']'
    StyleDirective ::= Symbol
    ColourDirective ::= '[' Symbol ',' Symbol ']'

Diagrams were produced using the Railroad Diagram Generator at `http://bottlecaps.de/rr/ui`.

## Usage

    class MyApp
      include Vedeu

      interface 'status', { y: 1, x: 1, width: :auto, height: 1     }
      interface 'main',   { y: 2, x: 1, width: :auto, height: :auto, fg: :red, bg: :black }

      command 'exit', Vedeu::Exit.dispatch, { keyword: "exit", keypress: "q" }
      command 'help', MyApp.help,           { keyword: "help", keypress: "h" }
    end

## Contributing

1. Fork it ( http://github.com/<my-github-username>/vedeu/fork )
2. Clone it
3. `bundle`
4. `rake` or `bundle exec guard`
5. Create your feature branch (`git checkout -b my-new-feature`)
6. Write some tests, write some code, have some fun
7. Commit your changes (`git commit -am 'Add some feature'`)
8. Push to the branch (`git push origin my-new-feature`)
9. Create new Pull Request

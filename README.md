[![Code Climate](https://codeclimate.com/github/gavinlaking/vedeu.png)](https://codeclimate.com/github/gavinlaking/vedeu)
[![Build Status](https://travis-ci.org/gavinlaking/vedeu.svg?branch=master)](https://travis-ci.org/gavinlaking/vedeu)

# Vedeu

Vedeu is my attempt at creating a terminal based application framework without the need for Ncurses. I've tried to make Vedeu as simple and flexible as possible.


## Installation

Add this line to your application's Gemfile:

    gem 'vedeu'

And then execute:

    $ bundle

## Usage

Expect proper documentation soon!

### Getting Started

    require 'vedeu'

    class MyApp
      include Vedeu

      interface :main, { }

      command   :exit, { entity:   SomeClass,
                         keypress: 'q',
                         keyword:  'quit' }
    end


### Some Terms

To understand how Vedeu works, you need to familiarise yourself with some terms.

  - Interface: This is an area on the screen where you can take input or direct output. You will define it's colour and style, its dimensions, including position and give it a name. You can then direct the output of a command to this interface and Vedeu will ensure the content is placed there. Interfaces can be layered, allowing pseudo 3D effects (if that floats your boat), or to provide a richer application experience.

  - Line: An interface is composed of many lines. Their length being the width of the interface and their number being the height of the interface.

  An interface with `width: 12, height: 5` will have five lines, each made of 12 characters.

  - Stream: A stream is a subset of a line. Having streams basically allow us to apply styles and colours to part of a line; their not necessary, but provide you with greater flexibility for your output.


### On Defining Interfaces

    interface :main, {
                y:          1,
                x:          1,
                z:          1,
                width:      :auto, # will set to terminal width
                height:     10,    # also accepts :auto
                colour: {
                  foreground: '#ffffff',
                  background: '#000000'
                },
                cursor:     false,
              }

Referring to the above example, interfaces have a name, and various default attributes.

`:y`          sets the starting row point. (See Geometry)
`:x`          sets the starting column point.
`:z`          an integer specifying the z-index of the interface.
              (See Layers)
`:width`      sets how many characters wide the interface will be.
`:height`     sets how many characters tall the interface will be.

`:foreground` sets the default foreground colour. (See Colours)
`:background` sets the default background colour.

`:cursor`     a boolean specifying whether the cursor should show.


### On Defining Commands

    command :do_something, {
              entity:    SomeClass,
              keypress:  's',
              keyword:   'start',
              arguments: [:some, { :values => :here }, "etc"] }

As above, commands have a name, a class which performs the action
(you define this), and they can be invoked with a keypress or a keyword. At this time, Vedeu will call the `.dispatch` method on your class, passing any arguments you originally defined in the command. In the future, both the method called and the arguments could be dynamic.


### Geometry

Geometry for Vedeu, as the same for ANSI terminals, is set top-left, which is point 1, 1. Interfaces have internal geometry which is handled automatically. Unless you are doing something special, you will probably only set it on a per-interface basis.


### Colours

Vedeu uses HTML/CSS style notation (i.e. '#aadd00'), they can be used at the stream level, the line level or for the whole interface.

    "colour": { "foreground": "#ff0000", "background": "#ffffff" }


### Styles

Vedeu has a range of symbol styles which are compatible with most terminals which are ANSI compatible.

    "style": []

Like colours, they can be defined in either interfaces, for specific lines or within streams. Styles are applied as encountered.


### Layers

Vedeu allows the overlaying of interfaces. To render these correctly,
Vedeu uses two rules.

  1) The :z value. 1 would be default, or bottom. 2 would be placed on top of 1. 3 on top of 2, and so on.
  2) If two interfaces occupy the same 'space', the interface which was defined last, wins.


## Contributing

1. Fork it ( http://github.com/gavinlaking/vedeu/fork )
2. Clone it
3. `bundle`
4. `rake` or `bundle exec guard`
5. Create your feature branch (`git checkout -b my-new-feature`)
6. Write some tests, write some code, have some fun
7. Commit your changes (`git commit -am 'Add some feature'`)
8. Push to the branch (`git push origin my-new-feature`)
9. Create new Pull Request

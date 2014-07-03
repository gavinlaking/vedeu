[![Code Climate](https://codeclimate.com/github/gavinlaking/vedeu.png)](https://codeclimate.com/github/gavinlaking/vedeu)

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

Vedeu uses HTML/CSS style notation (i.e. '#aadd00').


### Layers

Vedeu allows the overlaying of interfaces. To render these correctly,
Vedeu uses two rules.

  1) The :z value. 1 would be default, or bottom. 2 would be placed on top of 1. 3 on top of 2, and so on.
  2) If two interfaces occupy the same 'space', the interface which was defined last, wins.


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

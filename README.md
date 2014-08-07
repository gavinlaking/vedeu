[![Code Climate](https://codeclimate.com/github/gavinlaking/vedeu.png)](https://codeclimate.com/github/gavinlaking/vedeu)
[![Build Status](https://travis-ci.org/gavinlaking/vedeu.svg?branch=master)](https://travis-ci.org/gavinlaking/vedeu)

# Vedeu

Vedeu is my attempt at creating a terminal based application framework without the need for Ncurses. I've tried to make Vedeu as simple and flexible as possible.


## Installation

Add this line to your application's Gemfile:

    gem 'vedeu'

And then execute:

    $ bundle


## Example

Have a look at: https://github.com/gavinlaking/playa


## Usage

Expect proper documentation soon!

### Getting Started

    require 'vedeu'

    class MyApp
      include Vedeu

      interface 'main' do
        ...
      end

      event :some_event do
        # ...
      end

      event :other_event do |hash_args, array_args, args|
        # ...
      end

      event :key do |key|
        case key
        when 'a' then puts "Apple"
        when 'b' then puts "Banana"
        # ...
        when :f1 then run(:some_event)
        when :f2 then
          run(:other_event, { args: here }, [:or, :here], :etc)
        end
      end
    end


### Building Views

Views with Vedeu are made up of simple building blocks. These blocks can be arranged in a multitude of ways which I hope is more than sufficient for your design needs.

- Interfaces (`Interface`) are made up of lines. (`Line`)
- Lines are made up of zero, one or multiple streams. (`Stream`)
- An interface, line or stream can have a colour (`colour`) attribute.
- An interface, line or stream can have a style (`style`) attribute.
- Interfaces have a position (`y`, `x`) on the screen, and a size. (`width`, `height`)
- Interfaces can be placed relative to each other based on their attributes. (`top`, `right`, `bottom`, `left`)
- Colours are defined in CSS-style values, i.e. `#ff0000` would be red.
- Styles are named. See the table below for supported styles.


### Some Terms

To understand how Vedeu works, you need to familiarise yourself with some terms.

  - Interface: This is an area on the screen where you can take input or direct output. You will define it's colour and style, its dimensions, including position and give it a name. You can then direct the output of a command to this interface and Vedeu will ensure the content is placed there.

  - Line: An interface is composed of many lines. Their length being the width of the interface and their number being the height of the interface.

  An interface with `width: 12, height: 5` will have five lines, each made of 12 characters.

  - Stream: A stream is a subset of a line. Having streams basically allow us to apply styles and colours to part of a line; their not necessary, but provide you with greater flexibility for your output.


### On Defining Interfaces

    interface 'main' do
      y      1
      x      1
      width  10 # see notes below
      height 10
      colour foreground: '#ffffff', background: '#000000'
      cursor false
    end

Referring to the above example, interfaces have a name, and various default attributes.

- `y`          sets the starting row point. (See Geometry)
- `x`          sets the starting column point.

- `width`      sets character width of the interface
- `height`     sets character height of the interface

Note: not setting a width or height will set the values to the terminal's reported width and height.

- `foreground` sets the default foreground colour. (See Colours)
- `background` sets the default background colour.
- `cursor` is a Boolean specifying whether the cursor should show.


### On Defining Events

    event :event_name do |arg1, arg2|
    end

One can define events which perform work or trigger other events. Vedeu has 3 built-in events which are namespaced with underscores as to hopefully not cause a collision with events you wish to create:

- `:_exit_` when triggered, Vedeu will attempt to exit.

- `:_keypress_` triggering this event will cause the triggering of the `key` event; which you should define to 'do things'. If the `escape` key is pressed, then `key` is triggered with the argument `:escape`, also an internal event `_mode_switch_` is triggered.

- `:_mode_switch_` when triggered (after the user presses `escape`), Vedeu switches from a "raw mode" terminal to a "cooked mode" terminal. The idea here being that the raw mode is for single keypress actions, whilst cooked mode allows the user to enter more elaborate commands- such as commands with arguments.

Note: Overriding or adding additional events to the Vedeu event namespace may cause unpredictable results.


### Geometry

Geometry for Vedeu, as the same for ANSI terminals, is set top-left, which is point 1, 1. Interfaces have internal geometry which is handled automatically. Unless you are doing something special, you will probably only set it on a per-interface basis.


### Colours

Vedeu uses HTML/CSS style notation (i.e. '#aadd00'), they can be used at the stream level, the line level or for the whole interface.

    "colour": { "foreground": "#ff0000", "background": "#ffffff" }


### Styles

Vedeu has a range of symbol styles which are compatible with most terminals which are ANSI compatible.

    "style": []

Like colours, they can be defined in either interfaces, for specific lines or within streams. Styles are applied as encountered.

| Style name    | Escape Sequence          |
|---------------|--------------------------|
| bg_reset      | `\e[48;2;49m`            |
| blink         | `\e[5m`                  |
| blink_off     | `\e[25m`                 |
| bold          | `\e[1m`                  |
| bold_off      | `\e[21m`                 |
| clear         | `\e[2J`                  |
| colour_reset  | `\e[38;2;39m\e[48;2;49m` |
| fg_reset      | `\e[38;2;39m`            |
| hide_cursor   | `\e[?25l`                |
| negative      | `\e[7m`                  |
| positive      | `\e[27m`                 |
| reset         | `\e[0m`                  |
| normal        | `\e[24m\e[21m\e[27m`     |
| dim           | `\e[2m`                  |
| show_cursor   | `\e[?25h`                |
| underline     | `\e[4m`                  |
| underline_off | `\e[24m`                 |


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

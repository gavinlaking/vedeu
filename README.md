[![Code Climate](https://codeclimate.com/github/gavinlaking/vedeu.png)](https://codeclimate.com/github/gavinlaking/vedeu)
[![Build Status](https://travis-ci.org/gavinlaking/vedeu.svg?branch=master)](https://travis-ci.org/gavinlaking/vedeu)
[![Inline docs](http://inch-ci.org/github/gavinlaking/vedeu.svg?branch=master)](http://inch-ci.org/github/gavinlaking/vedeu)

# Vedeu

Vedeu is my attempt at creating a terminal based application framework without the need for Ncurses. I've tried to make Vedeu as simple and flexible as possible.


## Requirements

Vedeu has been built on MacOSX 10.9 (Mavericks) with Ruby v2.1.2.

Note: You may have trouble running Vedeu with Windows installations.


## Installation

Add this line to your application's Gemfile:

    gem 'vedeu'

And then execute:

    $ bundle


## Example

Have a look at: [Playa](https://github.com/gavinlaking/playa). Please browse the source of Playa and Vedeu to get a feel for how it all works. The [RubyDoc](http://rubydoc.info/github/gavinlaking/vedeu/master/frames) may also help!


## Usage

Expect proper documentation soon!

### Getting Started

The basic mechanics of a Vedeu app are outlined below:

```ruby
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
    when :f1 then trigger(:some_event)
    when :f2 then
      trigger(:other_event, { args: here }, [:or, :here], :etc)
    end
  end
end
```

### Building Interfaces & Views

Views with Vedeu are made up of simple building blocks. These blocks can be arranged in a multitude of ways which I hope is more than sufficient for your design needs.

- A view (`Composition`) is made up of one or more interfaces.
- An interface is an area on the screen where you can take input or direct output. You will define it's colour and style, its dimensions, including position and give it a name. You can then direct the output of a command, or event, to this interface and Vedeu will ensure the content is placed there.
- Interfaces (`Interface`) are made up of lines (`Line`), their length being the width of the interface and their number being the height of the interface.
- An interface with `width: 12, height: 5` will have five lines, each made of 12 characters- providing 60 cells. Colours and styles are handled by terminal escape sequences and therefore do not consume a cell.
- Lines are made up of zero, one or multiple streams (`Stream`) which are basically subsets of the line.
- An interface, line or stream can have a colour (`colour`) attribute.
- An interface, line or stream can have a style (`style`) attribute.
- Interfaces have a position (`y`, `x`) on the screen, and a size. (`width`, `height`)
- Interfaces can be placed relative to each other based on their attributes.
    - An interface has a `top`, `right`, `bottom`, `left`.
    - An interface also has a `north` and `west` (`top` and `left` minus 1 respectively).
    - An interface also has a `south` and `east` (`bottom` and `right` plus 1 respectively).
- Colours are defined in CSS-style values, i.e. `#ff0000` would be red.
- Styles are named. See the table below for supported styles.


### On Defining Interfaces

```ruby
interface 'main' do
  y      1
  x      1
  width  10 # see notes below
  height 10
  colour foreground: '#ffffff', background: '#000000'
  cursor false
end
```

Referring to the above example, interfaces have a name, and various default attributes.

- `y`          sets the starting row point. (See Geometry)
- `x`          sets the starting column point.

- `width`      sets the character width of the interface
- `height`     sets the character height of the interface

Note: not setting a width or height will set the values to the terminal's reported width and height.

- `foreground` sets the default foreground colour. (See Colours)
- `background` sets the default background colour.
- `cursor` is a Boolean specifying whether the cursor should show.


### On Defining Events

```ruby
event :event_name do |arg1, arg2|
end
```

One can define events which perform work or trigger other events. Vedeu has built-in events which are namespaced with underscores:

- `:_initialize_` Special event which Vedeu triggers when it is ready to enter the main loop. Client applications can listen for this event and perform some action(s), like render the first screen, interface or make a sound.

- `:_cleanup_` This event is fired by Vedeu when `:_exit_` is triggered. You can hook into this to perform a special action before the application terminates. Saving the user's work, session or preferences might be popular here.

- `:_clear_` Clears the whole terminal space.

- `:_exit_` when triggered, Vedeu will trigger a `:_cleanup_` event which you can define (to save files, etc) and attempt to exit.

- `:_keypress_` triggering this event will cause the triggering of the `:key` event; which you should define to 'do things'. If the `escape` key is pressed, then `key` is triggered with the argument `:escape`, also an internal event `_mode_switch_` is triggered.

- `:_mode_switch_` when triggered (after the user presses `escape`), Vedeu switches from a "raw mode" terminal to a "cooked mode" terminal. The idea here being that the raw mode is for single keypress actions, whilst cooked mode allows the user to enter more elaborate commands- such as commands with arguments.

- `:_refresh_` triggering this event will cause all interfaces to refresh.

- `:_refresh_group_(group_name)_` will refresh all interfaces belonging to this group. E.g. `_refresh_group_home_` will refresh all interfaces with the group of `home`.

- `:_refresh_(interface_name)_` will refresh the interface with this name. E.g. `_refresh_widget_` will refresh the interface `widget`.

Note: Overriding or adding additional events to the Vedeu event namespace may cause unpredictable results. It is recommended to only to hook into events like :_cleanup_, :_initialize_ and :key if you need to do something respective to those events.


### Geometry

Geometry for Vedeu, as the same for ANSI terminals, is set top-left, which is cell/point 1, 1. Interfaces themselves have internal geometry which is handled automatically. Unless you are doing something special, you will probably only set it on a per-interface basis.


### Colours

Vedeu uses HTML/CSS style notation (i.e. '#aadd00'), they can be used at the stream level, the line level or for the whole interface. Terminals generally support either 8, 16 or 256 colours, with few supporting full 24-bit colour. Vedeu attempts to detect the colour depth using the `$TERM` environment variable.

To set your `$TERM` variable to allow 256 colour support:

```bash
echo "export TERM=xterm-256color" >> ~/.bashrc
```

or, if you wish not to tamper with `$TERM`:

```bash
echo "export VEDEUTERM=xterm-256color" >> ~/.bashrc
```

If you know your terminal supports full 24-bit colour, set the `$VEDEUTERM` environment variable:

```bash
echo "export VEDEUTERM=xterm-truecolor" >> ~/.bashrc
```


### Styles

Vedeu has a range of symbol styles which are compatible with most terminals which are ANSI compatible. Like colours, they can be defined in either interfaces, for specific lines or within streams. Styles are applied as encountered.


## Development / Contributing

* Documentation hosted at [RubyDoc](http://rubydoc.info/github/gavinlaking/vedeu/master/frames).
* Source hosted at [GitHub](https://github.com/gavinlaking/vedeu).

Pull requests are very welcome! Please try to follow these simple rules if applicable:

* Please create a topic branch for every separate change you make.
* Make sure your patches are well tested.
* Update the [Yard](http://yardoc.org/) documentation.
* Update the [README](https://github.com/gavinlaking/vedeu/blob/master/README.md).
* Please **do not change** the version number.


### General contribution help

1. Fork it ([https://github.com/gavinlaking/vedeu/fork](https://github.com/gavinlaking/vedeu/fork))
2. Clone it
3. `bundle`
4. `rake` (runs all tests and coverage report) or `bundle exec guard`
5. Create your feature branch (`git checkout -b my-new-feature`)
6. Write some tests, write some code, have some fun!
7. Commit your changes (`git commit -am 'Add some feature'`)
8. Push to the branch (`git push origin my-new-feature`)
9. Create a new pull request.


## Author & Contributors

[Gavin Laking](https://github.com/gavinlaking) ([@gavinlaking](http://twitter.com/gavinlaking))


### Contributors

[https://github.com/gavinlaking/vedeu/graphs/contributors](https://github.com/gavinlaking/vedeu/graphs/contributors)

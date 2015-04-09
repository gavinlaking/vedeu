[![Code Climate](https://codeclimate.com/github/gavinlaking/vedeu.png)](https://codeclimate.com/github/gavinlaking/vedeu)
[![Build Status](https://travis-ci.org/gavinlaking/vedeu.svg?branch=master)](https://travis-ci.org/gavinlaking/vedeu)
[![Inline docs](http://inch-ci.org/github/gavinlaking/vedeu.svg?branch=master)](http://inch-ci.org/github/gavinlaking/vedeu)

# Vedeu

Vedeu (vee-dee-you; aka VDU) is my attempt at creating a terminal based application framework without the need for Ncurses. I've tried to make Vedeu as simple and flexible as possible.


## Requirements

Vedeu has been built primarily on MacOSX 10.9/10.10 (Mavericks/Yosemite) with
 Ruby v2.1.

Note: You may have trouble running Vedeu with Windows installations. (Pull requests welcome!)


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
    # ...
  end

  bind :some_event do
    # ...
  end

  bind :other_event do |hash_args, array_args, args|
    # ...
  end

  keys do
    key('a') { Vedeu.trigger(':apple') }
    key('b') { Vedeu.trigger(':banana') }
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
  geometry do
    y      1
    x      1
    width  10 # see notes below
    height 10
  end
  colour foreground: '#ffffff', background: '#000000'
end
```

Referring to the above example, interfaces have a name, and various default attributes.

- `y`          sets the starting row point. (See Geometry)
- `x`          sets the starting column point.

- `width`      sets the character width of the interface
- `height`     sets the character height of the interface

Note: not setting a width or height will set the values to the terminal's reported width and height.

- `foreground` sets the default foreground colour.
- `background` sets the default background colour.


### Events

More information about events can be found in the [RubyDoc](http://rubydoc.info/github/gavinlaking/vedeu/master/frames).


### Geometry

Geometry for Vedeu, as the same for ANSI terminals, is set top-left, which is cell/point 1, 1. Interfaces themselves have internal geometry which is handled automatically. Unless you are doing something special, you will probably only set it on a per-interface basis.


## Debugging & Environment Variables

Vedeu has two types of debugging; `VEDEU_DEBUG` and `VEDEU_TRACE`. Both of these can be configured at run-time using the arguments you pass to your application. They can also be enabled/disabled globally by setting environment variables (see below). These messages are written to `~/.vedeu/vedeu.log`.

To enable or disable, use true or false:

```bash
echo "export VEDEU_DEBUG=true" >> ~/.bashrc
echo "export VEDEU_TRACE=true" >> ~/.bashrc
```

Debugging (`VEDEU_DEBUG`) provides helpful messages which inform you what is happening in the application. Tracing (`VEDEU_TRACE`) is a noisy, blow-by-blow account of what is happening, letting you know which methods were called and which events have been triggered. Both (more so with tracing) can impact the performance of your application.


## Development / Contributing

* Documentation hosted at [RubyDoc](http://rubydoc.info/github/gavinlaking/vedeu/master/frames).
* Source hosted at [GitHub](https://github.com/gavinlaking/vedeu).

Pull requests are very welcome! Please try to follow these simple rules if applicable:

* Please create a topic branch for every separate change you make.
* Make sure your patches are well tested.
* Update the [Yard](http://yardoc.org/) documentation.
* Update the [README](https://github.com/gavinlaking/vedeu/blob/master/README.md).
* Please **do not change** the version number.

Any branch on the repository that is not `master` is probably experimental; do not rely on anything in these branches. Typically, `twerks` will be merged into `master` before a release,
and branches prefixed with `spike/` are me playing with ideas.


### General contribution help

1. Fork it ([https://github.com/gavinlaking/vedeu/fork](https://github.com/gavinlaking/vedeu/fork))
2. Clone it
3. Run `bundle`
4. Run `rake` (runs all tests and coverage report) or `bundle exec guard`
5. Create your feature branch (`git checkout -b my-new-feature`)
6. Write some tests, write some code, **have some fun!**
7. Commit your changes (`git commit -am 'Add some feature'`)
8. Push to the branch (`git push origin my-new-feature`)
9. Create a new pull request.


## Author & Contributors

### Author

[Gavin Laking](https://github.com/gavinlaking) ([@gavinlaking](http://twitter.com/gavinlaking))


### Contributors

[https://github.com/gavinlaking/vedeu/graphs/contributors](https://github.com/gavinlaking/vedeu/graphs/contributors)

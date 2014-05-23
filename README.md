[![Code Climate](https://codeclimate.com/github/gavinlaking/vedeu.png)](https://codeclimate.com/github/gavinlaking/vedeu)

# Vedeu

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'vedeu'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install vedeu

## Usage

TODO: Write detailed documentation

## Notes

    Application
      |-- Interfaces
      |     |-- Dummy < Interface
      |
      |-- Terminal

    Base
      |-- Translator
      |-- Esc

    Interface
      |-- Commands
      |     |-- Command
      |     |-- Exit
      |
      |-- Compositor
      |     |-- Directive
      |     |     |-- Colour
      |     |     |     |-- Foreground < Base
      |     |     |     |-- Background < Base
      |     |     |
      |     |     |-- Position
      |     |     |     |-- Esc
      |     |     |
      |     |     |-- Style
      |     |           |-- Esc
      |     |
      |     |-- Position
      |     |     |-- Esc
      |     |
      |     |-- Renderer
      |           |-- Terminal
      |
      |-- Geometry
      |     |-- Terminal
      |
      |-- Terminal

    Terminal
      |-- Esc
      |-- Position
            |-- Esc

### On Interfaces

When we create the interface we define it's width, height, and origin (y, x).
These numbers are based on the area available to the terminal. If the terminal is 80x25, then our interface can use all or some of this area.


## Contributing

1. Fork it ( http://github.com/<my-github-username>/vedeu/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

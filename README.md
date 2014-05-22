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
      |     |     |-- Style
      |     |           |-- Esc
      |     |
      |     |-- Terminal
      |
      |-- Terminal

    Terminal
      |-- Esc
      |-- Position


## Contributing

1. Fork it ( http://github.com/<my-github-username>/vedeu/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

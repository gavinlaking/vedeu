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
  |-- Clock
  |-- Screen
  |     |-- Dummy < Interface
  |
  |-- Terminal
        |-- Esc

Base
  |-- Translator
  |-- Esc

Composition
  |-- Mask
        |-- Foreground < Base
        |-- Background < Base
        |-- Translator

Grid < Composition
Row < Composition

Keyboard
  |-- Clock
  |-- Parser
  |     |-- Translator
  |     |-- Standard
  |     |-- Multibyte
  |           |-- Translator
  |           |-- Standard
  |
  |-- Terminal
        |-- Esc

Interface
  |-- Terminal
        |-- Esc


## Contributing

1. Fork it ( http://github.com/<my-github-username>/vedeu/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

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
  |-- Interfaces
  |     |-- Dummy < Interface
  |
  |-- Terminal
        |-- Esc
              |-- Mask

Base
  |-- Translator
  |-- Esc
        |-- Mask

Compositor
  |-- Mask
  |     |-- Foreground < Base
  |     |-- Background < Base
  |     |-- Translator
  |
  |-- Esc
        |-- Mask

Keyboard
  |-- Clock
  |-- Encoder
  |     |-- Translator
  |     |-- Standard
  |     |-- Multibyte
  |           |-- Translator
  |           |-- Standard
  |
  |-- Terminal
        |-- Esc
              |-- Mask

Interface
  |-- Terminal
        |-- Esc
              |-- Mask


## Contributing

1. Fork it ( http://github.com/<my-github-username>/vedeu/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

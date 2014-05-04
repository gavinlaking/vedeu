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

### Creating your colour palette

By default, Vedeu provides the ...

Vedeu::Custom.define(:name, Mask)

@param name [Symbol] - A named reference to the colour combination.
@param mask [Mask]   - An container which contains 2 elements.
                       - A symbol, this will point to another colour in the palette.
                       - A HTML string, i.e. '#00ff00'.


## Contributing

1. Fork it ( http://github.com/<my-github-username>/vedeu/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

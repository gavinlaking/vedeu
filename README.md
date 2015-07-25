[![Code Climate](https://codeclimate.com/github/gavinlaking/vedeu.png)](https://codeclimate.com/github/gavinlaking/vedeu)
[![Build Status](https://travis-ci.org/gavinlaking/vedeu.svg?branch=master)](https://travis-ci.org/gavinlaking/vedeu)

# Vedeu

Vedeu (vee-dee-you; aka VDU) is my attempt at creating a terminal based
 application framework without the need for Ncurses. I've tried to make Vedeu
 as simple and flexible as possible.


## Requirements

Vedeu was been built primarily with Ruby v2.1; however, the
[.ruby-version](https://github.com/gavinlaking/vedeu/blob/master/.ruby-version)
file will indicate the currently used Ruby version.

When Vedeu started I was a MacOSX user, I've since moved to Linux. You shouldn't
have any problems with either of these operating systems.

Note: You may have trouble running Vedeu with Windows installations. (Pull
 requests welcome!)


## Installation

To install Vedeu, simply:

    gem install 'vedeu'

To use Vedeu's application scaffolding, see the
[RubyDoc](http://www.rubydoc.info/gems/vedeu/file/docs/getting_started.md)

## Example

Have a look at: [Playa](https://github.com/gavinlaking/playa). Please browse the
source of Playa and Vedeu to get a feel for how it all works.

If you have produced software which uses Vedeu, please let me know, I'll link
to your project here.

## Documentation & Usage

Vedeu is largely documented using Yard. I hope to produce more 'General Usage'
documentation shortly. In the meantime, please browse the
[RubyDoc](http://rubydoc.info/gems/vedeu).

- [Getting Started](http://rubydoc.info/gems/vedeu/file/docs/getting_started.md)
- [The Vedeu DSL](http://rubydoc.info/gems/vedeu/file/docs/dsl.md)
- [The Vedeu API](http://rubydoc.info/gems/vedeu/file/docs/api.md)
- [Vedeu Events](http://rubydoc.info/gems/vedeu/file/docs/events.md)
- [Object Graphs](http://rubydoc.info/gems/vedeu/file/docs/object_graph.md)

## Development / Contributing

* Documentation hosted at [RubyDoc](http://rubydoc.info/gems/vedeu).
* Source hosted at [GitHub](https://github.com/gavinlaking/vedeu).

Pull requests are very welcome! Please try to follow these simple rules if
 applicable:

* Please create a topic branch for every separate change you make.
* Make sure your patches are well tested.
* Update the [Yard](http://yardoc.org/) documentation.
  (Use `yard stats --list-undoc` to locate undocumented code)
* Update the [README](https://github.com/gavinlaking/vedeu/blob/master/README.md).
* Please **do not change** the version number.

Any branch on the repository that is not `master` is probably experimental; do
 not rely on anything in these branches. Typically, `twerks` will be merged
 into `master` before a release, and branches prefixed with `spike/` are me
 playing with ideas.


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

[Gavin Laking](https://github.com/gavinlaking)
 ([@gavinlaking](http://twitter.com/gavinlaking))

### Contributors

[https://github.com/gavinlaking/vedeu/graphs/contributors](https://github.com/gavinlaking/vedeu/graphs/contributors)

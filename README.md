[![Code Climate](https://codeclimate.com/github/gavinlaking/vedeu.png)](https://codeclimate.com/github/gavinlaking/vedeu)
[![Build Status](https://travis-ci.org/gavinlaking/vedeu.svg?branch=master)](https://travis-ci.org/gavinlaking/vedeu)

# Vedeu
[![Gitter](https://badges.gitter.im/Join Chat.svg)](https://gitter.im/gavinlaking/vedeu?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

Vedeu (vee-dee-you; aka VDU) is my attempt at creating a terminal based
 application framework without the need for Ncurses. I've tried to make Vedeu
 as simple and flexible as possible.

## Requirements

- Ruby (see [.ruby-version](https://github.com/gavinlaking/vedeu/blob/master/.ruby-version) for current version)
- Linux/MacOSX

**Note**: You may have trouble running Vedeu with Windows installations. (Pull
 requests welcome!)

## Dependencies

Vedeu relies on the following gems, these will be automatically
 installed when you install Vedeu (as documented below).

- bundler
- rake
- vedeu_cli
  - thor

## Installation

To install Vedeu, simply:

    gem install vedeu

To use Vedeu's application scaffolding, see the
[RubyDoc](http://www.rubydoc.info/gems/vedeu/file/docs/getting_started.md)

## Example

Have a look at: [Playa](https://github.com/gavinlaking/playa). Please browse the
source of Playa and Vedeu to get a feel for how it all works.

**Note**: Playa is based on an old version of Vedeu. Vedeu has significantly
 improved since then and a better example is coming soon!

If you have produced software which uses Vedeu, please let me know, I'll link
to your project here.

## Documentation & Usage

Vedeu is documented using Yard. I hope to produce more 'General Usage'
documentation shortly. In the meantime, please browse the
[RubyDoc](http://rubydoc.info/gems/vedeu). Finally, here is some
documentation for the various aspects of Vedeu (not comprehensive):

- [The Vedeu API](http://rubydoc.info/gems/vedeu/file/docs/api.md)
- [Borders](http://rubydoc.info/gems/vedeu/file/docs/borders.md)
- [Buffers](http://rubydoc.info/gems/vedeu/file/docs/buffer.md)
- [Cell](http://rubydoc.info/gems/vedeu/file/docs/cell.md)
- [Chars](http://rubydoc.info/gems/vedeu/file/docs/chars.md)
- [Colours & Styles](http://rubydoc.info/gems/vedeu/file/docs/colours_styles.md)
- [Configuration](http://rubydoc.info/gems/vedeu/file/docs/configuration.md)
- [Cursors](http://rubydoc.info/gems/vedeu/file/docs/cursors.md)
- [The Vedeu DSL](http://rubydoc.info/gems/vedeu/file/docs/dsl.md)
- [Events](http://rubydoc.info/gems/vedeu/file/docs/events.md)
    - [Application Events](http://rubydoc.info/gems/vedeu/file/docs/events/application.md)
    - [Document Events](http://rubydoc.info/gems/vedeu/file/docs/events/document.md)
    - [Focus Events](http://rubydoc.info/gems/vedeu/file/docs/events/focus.md)
    - [Menu Events](http://rubydoc.info/gems/vedeu/file/docs/events/menu.md)
    - [Movement Events](http://rubydoc.info/gems/vedeu/file/docs/events/movement.md)
    - [Refresh Events](http://rubydoc.info/gems/vedeu/file/docs/events/refresh.md)
    - [System Events](http://rubydoc.info/gems/vedeu/file/docs/events/system.md)
    - [View Events](http://rubydoc.info/gems/vedeu/file/docs/events/view.md)
    - [Visibility Events](http://rubydoc.info/gems/vedeu/file/docs/events/visibility.md)
- [Geometry](http://rubydoc.info/gems/vedeu/file/docs/geometry.md)
- [Getting Started](http://rubydoc.info/gems/vedeu/file/docs/getting_started.md)
- [Groups](http://rubydoc.info/gems/vedeu/file/docs/group.md)
- [Input](http://rubydoc.info/gems/vedeu/file/docs/input.md)
- [Interfaces](http://rubydoc.info/gems/vedeu/file/docs/.md)
- [Keymaps](http://rubydoc.info/gems/vedeu/file/docs/keymaps.md)
- [Lines](http://rubydoc.info/gems/vedeu/file/docs/lines.md)
- [Object Graphs](http://rubydoc.info/gems/vedeu/file/docs/object_graph.md)
- [Output](http://rubydoc.info/gems/vedeu/file/docs/output.md)
- [Streams](http://rubydoc.info/gems/vedeu/file/docs/streams.md)
- [Template](http://rubydoc.info/gems/vedeu/file/docs/template.md)
- [Views](http://rubydoc.info/gems/vedeu/file/docs/view.md)

There are also some small, simple applications in the
[examples/](https://github.com/gavinlaking/vedeu/blob/master/examples)
directory to show some concepts and basic functionality. This is not
exhaustive, but are being added to and improved fairly regularly.

## Development / Contributing

* Documentation hosted at [RubyDoc](http://rubydoc.info/gems/vedeu).
* Source hosted at [GitHub](https://github.com/gavinlaking/vedeu).

Pull requests are very welcome! Please try to follow these simple rules if
 applicable:

* Please create a topic branch for every separate change you make.
* Make sure your patches are well tested.
* Update the [Yard](http://yardoc.org/) documentation.
  (Use `yard stats --list-undoc` to locate undocumented code)
* Update the
  [README](https://github.com/gavinlaking/vedeu/blob/master/README.md),
  if appropriate.
* Please **do not change** the version number.

Raising issues and finding bugs, updating documentation and improving
 the code are all welcome contributions. I may also have left some TODO
 items lying around, which you're quite welcome to and can find
 with either Yard, or git:

    yard list --query '@todo'

    git grep --line-number '@todo'


Any branch on the repository that is not `master` is probably experimental; do
 not rely on anything in these branches. Typically, `twerks` will be merged
 into `master` before a release, and branches prefixed with `spike/` are me
 playing with ideas- they aren't guaranteed to work at all.

Various environment variables are available to you to help with testing, all of
 which can be used in combination, prefaced to `rake`:

- Produce statistics on the slowest performing parts of the
  application/tests. Useful when used multiple times. See
  `test/test_helper.rb` for configuration.

        PERFORMANCE=1 rake

- Produce a 'SimpleCov' test coverage report in the `coverage/`
  directory.

        SIMPLECOV=1 rake

- Produces a 'SimpleCov' test coverage report with output to the
  console.

        CONSOLE_COVERAGE=1 rake

- Enable Ruby's warnings mode (this can usually be quote verbose, but
  thankfully more so with gem dependencies rather than Vedeu itself).

        WARNINGS=1 rake

- Disable Ruby's garbage collection for this test run.

        DISABLE_GC=1 rake

- Use Rubocop to catch coding misdemeanours for this test run. (Or
  use `rake rubocop`).

        RUBOCOP=1 rake

- Build the Yard documentation for the project. (Or use `rake yard`).

        YARD=1 rake


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

#!/usr/bin/env ruby

# frozen_string_literal: true

require 'bundler/setup'
require 'vedeu'

# An example application to demonstrate 'Hello World' and a minimum of
# interactivity.  It uses the DSL-style of vedeu (not the full-flegded
# MVC-approach).
#
# If you have cloned this repository from GitHub, you can run this example:
#
#     bundle exec ./examples/hello_worlds.rb
#
class HelloWorldsApp

  Vedeu.bind(:_initialize_) {
    Vedeu.trigger(:_show_view_, :hello)
    Vedeu.trigger(:_refresh_)
  }

  # Add specific configuration for the client application.
  #
  # Vedeu.configure do
  #   log Dir.tmpdir + '/vedeu.log'
  # end

  Vedeu.interface :hello do
    # Define all of the interface in one place.
    background '#000000'
    foreground '#00ff00'
    geometry do
      align vertical: :middle, horizontal: :centre, width: 24, height: 5
    end
    keymap do
      key('q') { Vedeu.exit }
      key('w') { HelloWorldsApp.render_world }
    end
  end

  Vedeu.renders do
    view :hello do
      lines do
        line { centre 'Hello Worlds!', width: 24 }
        line
        line { centre "Press 'q' to exit,",     width: 24 }
        line { centre " 'w' to switch worlds.", width: 24 }
      end
    end
  end

  def self.start(argv = ARGV)
    Vedeu::Launcher.execute!(argv)
  end

  private

  def self.render_world
    # Immediately render this to screen.
    Vedeu.render do
      view :hello do
        geometry do
          align vertical: :middle, horizontal: :centre, width: (24 + 2), height: (5 + 2)
        end
        border do
          colour foreground: ["#00ff00", "#000033", "#cddc39", "#03a9f4"].sample
          title ["atlantis", "oceania", "utopia", "midgard", "middle-earth"].sample
        end
        lines do
          line { centre 'Hello Worlds!', width: 24 }
          line
          line { centre "Press 'q' to exit,",     width: 24 }
          line { centre " 'w' to switch worlds.", width: 24 }
          line { centre "#{Vedeu.trigger(:_cursor_position_, Vedeu.focus)}" }
        end
      end
    end
  end

end # HelloWorldsApp

HelloWorldsApp.start(ARGV)

#!/usr/bin/env ruby

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

  Vedeu.bind(:_initialize_) { Vedeu.trigger(:_refresh_) }

  Vedeu.configure do
    # Empty configure block is needed.
  end

  Vedeu.interface :hello do
    # Define all of the interface in one place.
    background '#000000'
    foreground '#00ff00'
    geometry do
      centred!
      height   5
      width    24
    end
    # (You usually specify the views outside the interface block).
    Vedeu.views do
      view :hello do
        lines do
          line { centre 'Hello Worlds!', width: 24 }
          line
          line { centre "Press 'q' to exit,",     width: 24 }
          line { centre " 'w' to switch worlds.", width: 24 }
        end
      end
    end
    keymap do
      key('q') { Vedeu.exit }
      key('w') { HelloWorldsApp.render_world }
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
          centred!
          height  5 + 2
          width   24 + 2
        end
        border :hello do
          colour foreground: ["#00ff00", "#000033", "#cddc39", "#03a9f4"].sample
          title ["atlantis", "oceania", "utopia", "midgard", "middle-earth"].sample
        end
        lines do
          line { centre 'Hello Worlds!', width: 24 }
          line
          line { centre "Press 'q' to exit,",     width: 24 }
          line { centre " 'w' to switch worlds.", width: 24 }
        end
      end
    end
  end

end # HelloWorldsApp

HelloWorldsApp.start(ARGV)

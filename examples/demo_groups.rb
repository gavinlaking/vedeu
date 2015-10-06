#!/usr/bin/env ruby

require 'bundler/setup'
require 'vedeu'

# If you have cloned this repository from GitHub, you can run this example:
#
#     bundle exec ./examples/demo_groups.rb
#
class DemoGroupsApp

  Vedeu.bind(:_initialize_) {
    Vedeu.trigger(:_show_group_, :fruit)
    Vedeu.trigger(:_refresh_group_, :fruit)
  }

  Vedeu.configure do
    log '/tmp/demo_groups.log'
  end

  Vedeu.interface :apple do
    border!
    foreground '#ffffff'
    geometry do
      width  10
      height 4
      x  3
      y  3

    end
    group :fruit
  end

  Vedeu.interface :banana do
    border!
    foreground '#ffffff'
    geometry do
      width  10
      height 4
      x  15
      y  3
    end
    group :fruit
  end

  Vedeu.interface :carrot do
    border!
    foreground '#ffffff'
    geometry do
      width  10
      height 4
      x  4
      y  4
    end
    group :vegetable
  end

  Vedeu.interface :dill do
    border!
    foreground '#ffffff'
    geometry do
      width  10
      height 4
      x  16
      y  4
    end
    group :vegetable
  end

  Vedeu.keymap '_global_' do
    key('f') {
      Vedeu.trigger(:_hide_group_, :vegetable)
      Vedeu.trigger(:_show_group_, :fruit)
    }
    key('q') { Vedeu.exit }
    key('v') {
      Vedeu.trigger(:_hide_group_, :fruit)
      Vedeu.trigger(:_show_group_, :vegetable)
    }
    key(:tab) { Vedeu.focus_next }
    key(:shift_tab) { Vedeu.focus_previous }
  end

  Vedeu.views do
    view(:apple) do
      line 'apple'
    end
    view(:banana) do
      line 'banana'
    end
    view(:carrot) do
      line 'carrot'
    end
    view(:dill) do
      line 'dill'
    end
  end

  def self.start(argv = ARGV)
    Vedeu::Launcher.execute!(argv)
  end

end # DemoGroupsApp

DemoGroupsApp.start

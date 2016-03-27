#!/usr/bin/env ruby

# frozen_string_literal: true

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
    debug!
    log Dir.tmpdir + '/demo_groups.log'
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
      lines do
        line 'apple'
      end
    end
    view(:banana) do
      lines do
        line 'banana'
      end
    end
    view(:carrot) do
      lines do
        line 'carrot'
      end
    end
    view(:dill) do
      lines do
        line 'dill'
      end
    end
  end

  def self.start(argv = ARGV)
    Vedeu::Launcher.execute!(argv)
  end

end # DemoGroupsApp

DemoGroupsApp.start

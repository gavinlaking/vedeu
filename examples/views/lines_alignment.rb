#!/usr/bin/env ruby

require 'bundler/setup'
require 'vedeu'

class DSLApp

  Vedeu.bind(:_initialize_) { Vedeu.trigger(:_refresh_) }

  Vedeu.configure do
    debug!
    log '/tmp/vedeu_views_dsl.log'
    run_once!
    standalone!
  end

  Vedeu.interface :test1_interface do
    border do
      title ':centre'
    end
    geometry do
      x  4
      y  3
      xn 34
      yn 8
    end
  end

  Vedeu.interface :test2_interface do
    border do
      title ':center'
    end
    geometry do
      x  36
      y  3
      xn 66
      yn 8
    end
  end

  Vedeu.interface :test3_interface do
    border do
      title ':left'
    end
    geometry do
      x  4
      y  10
      xn 34
      yn 15
    end
  end

  Vedeu.interface :test4_interface do
    border do
      title ':right'
    end
    geometry do
      x  36
      y  10
      xn 66
      yn 15
    end
  end

  Vedeu.keymap '_global_' do
    key('q') { Vedeu.exit }
  end

  Vedeu.render do
    view(:test1_interface) do
      lines do
        centre 'view->lines->centre'
      end
    end
    view(:test2_interface) do
      lines do
        center 'view->lines->center'
      end
    end
    view(:test3_interface) do
      lines do
        left 'view->lines->left'
      end
    end
    view(:test4_interface) do
      lines do
        right 'view->lines->right'
      end
    end
  end

  def self.start(argv = ARGV)
    Vedeu::Launcher.execute!(argv)
  end

end # EditorApp

DSLApp.start

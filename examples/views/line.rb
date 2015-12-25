#!/usr/bin/env ruby

# frozen_string_literal: true

require 'bundler/setup'
require 'vedeu'

class DSLApp

  Vedeu.bind(:_initialize_) { Vedeu.trigger(:_refresh_) }

  Vedeu.configure do
    debug!
    log '/tmp/vedeu_views_dsl.log'
    renderers(Vedeu::Renderers::Terminal.new,
              Vedeu::Renderers::File.new(filename: '/tmp/line.out'))
    run_once!
    standalone!
  end

  Vedeu.interface :test1_interface do
    border do
      title 'Test 1'
    end
    geometry do
      x  4
      y  3
      xn 34
      yn 8
    end
  end

  Vedeu.interface :help1_interface do
    geometry do
      x  use(:test1_interface).x
      y  use(:test1_interface).south
      xn use(:test1_interface).xn
      yn use(:test1_interface).south(3)
    end
  end

  Vedeu.interface :test2_interface do
    border do
      title 'Test 2'
    end
    geometry do
      x      use(:test1_interface).east(6)
      y      use(:test1_interface).y
      width  use(:test1_interface).width
      height use(:test1_interface).height
    end
  end

  Vedeu.interface :help2_interface do
    geometry do
      x  use(:test2_interface).x
      y  use(:test2_interface).south
      xn use(:test2_interface).xn
      yn use(:test2_interface).south(3)
    end
  end

  Vedeu.interface :test3_interface do
    border do
      title 'Test 3'
    end
    geometry do
      x  use(:help1_interface).x
      y  use(:help1_interface).south
      xn use(:help1_interface).xn
      yn use(:help1_interface).south(5)
    end
  end

  Vedeu.interface :help3_interface do
    geometry do
      x  use(:test3_interface).x
      y  use(:test3_interface).south
      xn use(:test3_interface).xn
      yn use(:test3_interface).south(5)
    end
  end

  Vedeu.interface :test4_interface do
    border do
      title 'Test 4'
    end
    geometry do
      x  use(:help2_interface).x
      y  use(:help2_interface).south
      xn use(:help2_interface).xn
      yn use(:help2_interface).south(5)
    end
  end

  Vedeu.interface :help4_interface do
    geometry do
      x  use(:test4_interface).x
      y  use(:test4_interface).south
      xn use(:test4_interface).xn
      yn use(:test4_interface).south(5)
    end
  end

  Vedeu.interface :test5_interface do
    border do
      title 'Test 5'
    end
    geometry do
      x  use(:help1_interface).x
      y  use(:help3_interface).south
      xn use(:help1_interface).xn
      yn use(:help3_interface).south(5)
    end
  end

  Vedeu.interface :help5_interface do
    geometry do
      x  use(:test5_interface).x
      y  use(:test5_interface).south
      xn use(:test5_interface).xn
      yn use(:test5_interface).south(5)
    end
  end

  Vedeu.render do
    view(:test1_interface) do
      background '#440000'
      line 'view->line', { foreground: '#ff0000' }
    end

    view(:help1_interface) do
      line 'A single line within a view.'
    end

    view(:test2_interface) do
      line 'view->line 1', { foreground: '#ff7f00' }
      line 'view->line 2', { foreground: '#ffff00' }
    end

    view(:help2_interface) do
      line 'Multiple lines within a view.'
      line '(No block)'
    end

    view(:test3_interface) do
      text 'view->text 1', { foreground: '#00ff00' }
      text 'view->text 2', { foreground: '#007fff' }
    end

    view(:help3_interface) do
      text 'Multiple `text` keywords within'
      text 'a view are treated as separate'
      text 'lines.'
    end

    view(:test4_interface) do
      line do
        text 'view->line 1->text', { foreground: '#5500cc' }
      end
      line do
        text 'view->line 2->text 1', { foreground: '#ff00ff' }
        text 'view->line 2->text 2', { foreground: '#ffffff' }
      end
    end

    view(:help4_interface) do
      line do
        foreground '#ff0000'
        text 'Line `block` syntax.'
      end
      line do
        background '#ffff00'
        foreground '#000000'
        text 'A single '
        text '`text` ', { background: '#000000', foreground: '#ffff00' }
        text 'is just a'
      end
      line do
        colour background: '#ff0000'
        text 'stream within a line, whilst'
      end
      line do
        colour foreground: '#006600'
        text 'multiple '
        text '`text`', { foreground: '#ff0000' }
        text 's are treated'
      end
      line do
        colour background: '#000066', foreground: '#ff9999'
        text 'as separate streams.'
      end
      line do
        foreground '#ff0000'
        text 'Line `block` syntax.', { background: '#00ff00' }
      end
    end

    view(:test5_interface) do
      lines do
        background '#000066'
        line 'view->lines->line 1', { foreground: '#00ff00' }
        line 'view->lines->line 2', { background: '#000000', foreground: '#007fff' }
        line 'view->lines->line 3', { foreground: '#55aa00' }
      end
    end

    view(:help5_interface) do
      lines do
        line 'Multiple `line` keywords within'
        line 'a `lines` block view are'
        line 'treated as separate lines.'
      end
    end
  end

  def self.start(argv = ARGV)
    Vedeu::Launcher.execute!(argv)
  end

end # DSLApp

DSLApp.start

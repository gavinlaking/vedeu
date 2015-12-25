#!/usr/bin/env ruby

require 'bundler/setup'
require 'vedeu'

class DSLApp

  Vedeu.bind(:_initialize_) { Vedeu.trigger(:_refresh_) }

  Vedeu.configure do
    debug!
    log '/tmp/vedeu_views_dsl.log'
    renderers Vedeu::Renderers::Terminal.new, Vedeu::Renderers::File.new(filename: '/tmp/lines_alignment.out')
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
      xn 35
      yn 8
    end
  end

  Vedeu.interface :help1_interface do
    geometry do
      x  use(:test1_interface).x
      y  use(:test1_interface).south
      xn use(:test1_interface).xn
      yn use(:test1_interface).south(5)
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
      yn use(:test2_interface).south(5)
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

  Vedeu.interface :test6_interface do
    border do
      title 'Test 6'
    end
    geometry do
      x  use(:help4_interface).x
      y  use(:help4_interface).south
      xn use(:help4_interface).xn
      yn use(:help4_interface).south(5)
    end
  end

  Vedeu.interface :help6_interface do
    geometry do
      x  use(:test6_interface).x
      y  use(:test6_interface).south
      xn use(:test6_interface).xn
      yn use(:test6_interface).south(5)
    end
  end

  Vedeu.render do
    view(:test1_interface) do
      line 'view->line (align: :left)',   { align: :left }
      line 'view->line (align: :center)', { align: :center }
      line 'view->line (align: :centre)', { align: :centre }
      line 'view->line (align: :right)',  { align: :right }
    end

    view(:help1_interface) do
      line '`:align` option on the `line`'
      line 'DSL method. (no width or name'
      line 'set)'
    end

    view(:test2_interface) do
      left 'view->left'
      center 'view->center'
      centre 'view->centre'
      right 'view->right'
    end

    view(:help2_interface) do
      lines do
        ''
      end
    end

    view(:test3_interface) do
      lines do
        left 'view->lines->left 1', { foreground: '#ff0000' }
        left 'view->lines->left 2', { background: '#ff0000', foreground: '#000000' }
      end
    end

    view(:help3_interface) do
      lines do
        ''
      end
    end

    view(:test4_interface) do
      lines do
        right 'view->lines->right 1', { foreground: '#00ff00' }
        right 'view->lines->right 2', { background: '#00ff00', foreground: '#000000' }
      end
    end

    view(:help4_interface) do
      lines do
        ''
      end
    end

    view(:test5_interface) do
      lines do
        centre 'view->lines->centre 1', { foreground: '#0044ff' }
        centre 'view->lines->centre 2', { background: '#0044ff', foreground: '#000000' }
      end
    end

    view(:help5_interface) do
      lines do
        ''
      end
    end

    view(:test6_interface) do
      foreground '#ffffff'
      line do
        left   'v->l->left',   { background: '#aa2200', width: 15 }
        right  'v->l->right',  { background: '#0022ff', width: 15 }
      end
      line do
        centre 'v->l->centre', { background: '#007700', width: 30 }
      end
    end

    view(:help6_interface) do
    end
  end

  def self.start(argv = ARGV)
    Vedeu::Launcher.execute!(argv)
  end

end # DSLApp

DSLApp.start

#!/usr/bin/env ruby

# frozen_string_literal: true

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

  Vedeu.render do
    view(:test1_interface) do
      lines do
        streams do
          text 'v->ls->ss->text 1', { foreground: '#00ff00' }
          text 'v->ls->ss->text 2', { foreground: '#0000ff' }
        end
      end
    end

    view(:help1_interface) do
    end

    view(:test2_interface) do
      lines do
        streams do
          stream 'v->ls->ss->stream 1', { foreground: '#00ff00' }
          stream 'v->ls->ss->stream 2', { foreground: '#ff0000' }
        end
      end
    end

    view(:help2_interface) do
    end
  end

  def self.start(argv = ARGV)
    Vedeu::Launcher.execute!(argv)
  end

end # DSLApp

DSLApp.start

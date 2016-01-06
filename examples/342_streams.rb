#!/usr/bin/env ruby

# frozen_string_literal: true

require 'bundler/setup'
require 'vedeu'

class DSLApp

  Vedeu.bind(:_initialize_) { Vedeu.trigger(:_refresh_) }

  Vedeu.configure do
    height 5
    debug!
    log '/tmp/vedeu_views_dsl.log'
    renderers(Vedeu::Renderers::Terminal.new(
                filename: '/tmp/vedeu_342_streams.out',
                write_file: true))
    run_once!
    standalone!
  end

  Vedeu.interface :test1_interface do
    background '#000022'
    geometry do
      x  3
      y  3
      xn 53
      yn 3
    end
  end

  Vedeu.render do
    view(:test1_interface) do
      line do
        stream do
          foreground '#cc66ff'
          left Time.now.strftime('%d/%m/%Y %H:%M:%S')
        end
        stream do
          foreground '#007777'
          left ' null'
        end
        stream do
          foreground '#dddddd'
          left ' > hi'
        end
      end
    end
  end

  def self.start(argv = ARGV)
    Vedeu::Launcher.execute!(argv)
  end

end # DSLApp

DSLApp.start

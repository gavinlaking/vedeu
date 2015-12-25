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

  Vedeu.render do
    view(:test1_interface) do
      lines do
        streams do
          text 'v->ls->ss->text 1', { foreground: '#00ff00' }
          text 'v->ls->ss->text 2', { foreground: '#0000ff' }
        end
      end
    end
  end

  def self.start(argv = ARGV)
    Vedeu::Launcher.execute!(argv)
  end

end # DSLApp

DSLApp.start

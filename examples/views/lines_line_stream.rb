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

  Vedeu.interface :test2_interface do
    border do
      title 'Test 2'
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
      title 'Test 3'
    end
    geometry do
      x  4
      y  10
      xn 34
      yn 15
    end
  end

  Vedeu.render do
    view(:test1_interface) do
      lines do
        line do
          stream 'view->lines->line->stream', { foreground: '#ff77ff' }
        end
      end
    end

    view(:test2_interface) do
      lines do
        line do
          stream do
            text 'v->ls->l->s->text 1', { foreground: '#7700ff' }
            text 'v->ls->l->s->text 2', { foreground: '#ff7700' }
          end
        end
      end
    end

    view(:test3_interface) do
      lines do
        line do
          stream do
            text 'stream 1->text 1', { foreground: '#ff7700' }
          end
          stream do
            text 'stream 2->text 1', { foreground: '#7700ff' }
          end
        end
      end
    end
  end

  def self.start(argv = ARGV)
    Vedeu::Launcher.execute!(argv)
  end

end # DSLApp

DSLApp.start

#!/usr/bin/env ruby

# frozen_string_literal: true

require 'bundler/setup'
require 'vedeu'

class DSLApp

  Vedeu.bind(:_initialize_) { Vedeu.trigger(:_refresh_) }

  Vedeu.configure do
    debug!
    log '/tmp/vedeu_views_dsl.log'
    renderers(Vedeu::Renderers::Terminal.new(
                filename: '/tmp/vedeu_lines_alignment.out',
                write_file: true),
              Vedeu::Renderers::JSON.new(
                filename: '/tmp/vedeu_lines_alignment.json'),
              Vedeu::Renderers::HTML.new(
                filename: '/tmp/vedeu_lines_alignment.html'),
              Vedeu::Renderers::Text.new(
                filename: '/tmp/vedeu_lines_alignment.txt')
             )
    run_once!
    standalone!
  end

  load './_interfaces.rb'

  Vedeu.border :test2_interface do
    background '#220022'
    foreground '#00aaff'
    title      'Test 2'
  end

  Vedeu.render do
    view(:test1_interface) do
      background '#002200'
      foreground '#aaff00'
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

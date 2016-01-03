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
                filename: '/tmp/vedeu_lines.out',
                write_file: true),
              Vedeu::Renderers::JSON.new(
                filename: '/tmp/vedeu_lines.json'),
              Vedeu::Renderers::HTML.new(
                filename: '/tmp/vedeu_lines.html'))
    run_once!
    standalone!
  end

  load './_interfaces.rb'

  Vedeu.render do
    view(:test1_interface) do
      stream 'view->stream', { foreground: '#ff0000' }
    end

    view(:help1_interface) do
      stream 'A single stream within a view.'
    end

    view(:test2_interface) do
      stream 'view->stream 1', { foreground: '#ff7f00' }
      stream 'view->stream 2', { foreground: '#ffff00' }
    end

    view(:help2_interface) do
      stream 'Multiple streams within a view.'
      stream '(No line/lines block)'
    end

    view(:test3_interface) do
      line do
        stream 'view->line 1->stream', { foreground: '#00ff00' }
      end
      line do
        stream 'view->line 2->stream 1', { foreground: '#007fff' }
        stream 'view->line 2->stream 2', { foreground: '#ff00ff' }
      end
    end

    view(:help3_interface) do
      line do
        stream 'Multiple `stream` keywords'
      end
      line do
        stream 'within a line '
        stream '(block) are'
      end
      line do
        stream 'treated as separate streams.'
      end
    end

    view(:test4_interface) do
      lines do
        line do
          stream 'view->lines->line->stream', { foreground: '#5500cc' }
        end
        line do
          stream 'view->stream 2->text 1', { foreground: '#ff00ff' }
          stream 'view->stream 2->text 2', { foreground: '#ffffff' }
        end
      end
    end

    view(:help4_interface) do
      lines do
        line do
          stream 'A single stream within a line', { foreground: '#5500cc' }
        end
        line do
          stream 'block, ',                { foreground: '#5500cc' }
          stream 'is treated as a single', { foreground: '#5500cc' }
        end
        line do
          stream 'line. ',    { foreground: '#5500cc' }
          stream 'Multiple ', { foreground: '#ff00ff' }
          stream '`stream` ', { foreground: '#ffffff' }
          stream 'entries',   { foreground: '#ff00ff' }
        end
        line do
          stream 'are treated as ', { foreground: '#ff00ff' }
          stream 'separate streams', { foreground: '#ffffff' }
        end
        line do
          stream 'in the line.', { foreground: '#ff00ff' }
        end
      end
    end

    view(:test5_interface) do
      stream do
        text 'view->stream->text 1', { foreground: '#00ff00' }
        text 'view->stream->text 2', { foreground: '#007fff' }
      end
    end

    view(:help5_interface) do
      stream do
        text 'Multiple ',       { foreground: '#00ff00' }
        text '`text` ',         { foreground: '#007fff' }
        text 'keywords within', { foreground: '#00ff00' }
      end
      stream do
        text 'a ',             { foreground: '#00ff00' }
        text '`stream` ',      { foreground: '#007fff' }
        text 'block view are', { foreground: '#00ff00' }
      end
      stream do
        text 'treated as ',       { foreground: '#00ff00' }
        text 'separate streams.', { foreground: '#007fff' }
      end
    end

    view(:test6_interface) do
      line do
        streams do
          stream 'v->l->ss->stream 1', { foreground: '#00ff00' }
          stream 'v->l->ss->stream 2', { foreground: '#007fff' }
        end
      end
    end

    view(:help6_interface) do
      line do
        streams do
          stream 'Multiple ', { foreground: '#00ff00' }
          stream '`stream` ', { foreground: '#007fff' }
          stream 'within a ', { foreground: '#00ff00' }
        end
      end
      line do
        streams do
          stream '`streams` ', { foreground: '#007fff' }
          stream 'within a ',  { foreground: '#00ff00' }
          stream '`line`',     { foreground: '#007fff' }
          stream '.',          { foreground: '#00ff00' }
        end
      end
    end
  end

  def self.start(argv = ARGV)
    Vedeu::Launcher.execute!(argv)
  end

end # DSLApp

DSLApp.start

#!/usr/bin/env ruby

# frozen_string_literal: true

require 'bundler/setup'
require 'vedeu'

class DSLApp

  Vedeu.configure do
    log Dir.tmpdir + '/vedeu_views_dsl.log'
    renderers(Vedeu::Renderers::Terminal.new(
                filename: Dir.tmpdir + '/vedeu_full_screen.out',
                write_file: true),
              Vedeu::Renderers::JSON.new(
                filename: Dir.tmpdir + '/vedeu_full_screen.json'),
              Vedeu::Renderers::HTML.new(
                filename: Dir.tmpdir + '/vedeu_full_screen.html'),
              Vedeu::Renderers::Text.new(
                filename: Dir.tmpdir + '/vedeu_full_screen.txt')
              )
    debug!
    run_once!
    standalone!
  end

  Vedeu.bind(:_initialize_) { Vedeu.trigger(:_refresh_) }

  Vedeu.interface :test1_interface do
    background '#000066'
    foreground '#ffffff'
    border do
      title "Width: #{Vedeu.width} Height: #{Vedeu.height}"
    end
    # geometry do
    #   width 90
    #   height 40
    #   x  4
    #   y  3
    #   xn 34
    #   yn 8
    # end
  end

  Vedeu.render do
    view(:test1_interface) do
      line do
        stream '--------1---------2---------3---------4---------5', {
          foreground: '#ff0000'
        }
        stream '---------6---------7---------8---------9---------', {
          foreground: '#ff0000'
        }
        stream '0', { foreground: '#ffff00' }
        stream '---------1---------2---------3---------4---------5', {
          foreground: '#00ff00'
        }
        stream '---------6---------7---------8---------9---------', {
          foreground: '#00ff00'
        }
        stream '0', { foreground: '#ffff00' }
        stream '-2-4-6-8-1-2-4-----2---------3---------4---------5', {
          foreground: '#0077ff'
        }
      end
      line do
        stream '- '
      end
      line '-'
      line '-'
      line '-'
      line '-'
      line '-'
      line '-'
      line '10'
      line '-'
      line '-'
      line '-'
      line '-'
      line '-'
      line '-'
      line '-'
      line '-'
      line '-'
      line '20'
      line '-'
      line '-'
      line '-'
      line '-'
      line '-'
      line '-'
      line '-'
      line '-'
      line '-'
      line '30'
      line '-'
      line '-'
      line '-'
      line '-'
      line '-'
      line '-'
      line '-'
      line '-'
      line '-'
      line '40'
      line '-'
      line '-'
      line '-'
      line '-'
      line '-'
      line '-'
      line '-'
      line '-'
      line '-'
      line '50'
      line '-'
      line '-'
      line '-'
      line '-'
      line '-'
      line '-'
      line '-'
      line '-'
      line '-'
      line '60'
    end
  end

  def self.start(argv = ARGV)
    Vedeu::Launcher.execute!(argv)
  end

end # DSLApp

DSLApp.start

#!/usr/bin/env ruby

# frozen_string_literal: true

require 'bundler/setup'
require 'vedeu'

class DSLApp

  Vedeu.bind(:_initialize_) { Vedeu.trigger(:_refresh_) }

  Vedeu.configure do
    debug!
    log Dir.tmpdir + '/vedeu_views_dsl.log'
    renderers(Vedeu::Renderers::Terminal.new(
                filename: Dir.tmpdir + '/vedeu_empty.out',
                write_file: true),
              Vedeu::Renderers::JSON.new(
                filename: Dir.tmpdir + '/vedeu_empty.json'),
              Vedeu::Renderers::HTML.new(
                filename: Dir.tmpdir + '/vedeu_empty.html'),
              Vedeu::Renderers::Text.new(
                filename: Dir.tmpdir + '/vedeu_empty.txt')
              )
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
      end
    end
  end

  def self.start(argv = ARGV)
    Vedeu::Launcher.execute!(argv)
  end

end # DSLApp

DSLApp.start

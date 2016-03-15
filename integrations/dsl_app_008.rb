#!/usr/bin/env ruby

# frozen_string_literal: true

require 'bundler/setup'
require 'vedeu'

TESTCASE = 'dsl_app_008'

class DSLApp

  Vedeu.bind(:_initialize_) { Vedeu.trigger(:_refresh_) }

  Vedeu.configure do
    debug!
    height 10
    log '/tmp/vedeu_views_dsl.log'
    renderers [
                Vedeu::Renderers::Terminal.new(
                  filename: "/tmp/#{TESTCASE}.out",
                  write_file: true),
                # Vedeu::Renderers::JSON.new(filename: "/tmp/#{TESTCASE}.json"),
                # Vedeu::Renderers::HTML.new(filename: "/tmp/#{TESTCASE}.html"),
                # Vedeu::Renderers::Text.new(filename: "/tmp/#{TESTCASE}.txt"),
              ]
    run_once!
    standalone!
  end

  load File.dirname(__FILE__) + '/support/test_interface.rb'

  Vedeu.render do
    view(:test_interface) do
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
  end

  def self.start(argv = ARGV)
    Vedeu::Launcher.execute!(argv)
  end

end # DSLApp

Vedeu.timer('Test') do
  DSLApp.start
end

load File.dirname(__FILE__) + '/test_runner.rb'
TestRunner.result(TESTCASE, __FILE__)

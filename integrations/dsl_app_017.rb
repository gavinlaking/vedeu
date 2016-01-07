#!/usr/bin/env ruby

# frozen_string_literal: true

require 'bundler/setup'
require 'vedeu'

TESTCASE = 'dsl_app_017'

class DSLApp

  Vedeu.bind(:_initialize_) { Vedeu.trigger(:_refresh_) }

  Vedeu.configure do
    debug!
    height 10
    log Dir.tmpdir + '/vedeu_views_dsl.log'
    renderers [
                Vedeu::Renderers::Terminal.new(
                  filename: Dir.tmpdir + "/#{TESTCASE}.out",
                  write_file: true),
                # Vedeu::Renderers::JSON.new(filename: Dir.tmpdir + "/#{TESTCASE}.json"),
                # Vedeu::Renderers::HTML.new(filename: Dir.tmpdir + "/#{TESTCASE}.html"),
                # Vedeu::Renderers::Text.new(filename: Dir.tmpdir + "/#{TESTCASE}.txt"),
              ]
    run_once!
    standalone!
  end

  load File.dirname(__FILE__) + '/support/test_interface.rb'

  Vedeu.render do
    view(:test_interface) do
      foreground '#ffffff'
      line do
        left  'v->l->left',   { background: '#aa00ff' }
        right 'v->l->right',  { background: '#5a5a5a' }
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

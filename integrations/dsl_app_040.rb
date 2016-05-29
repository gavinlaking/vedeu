#!/usr/bin/env ruby

# frozen_string_literal: true

require 'bundler/setup'
require 'vedeu'

TESTCASE = 'dsl_app_040'

class DSLApp

  Vedeu.bind(:_initialize_) { Vedeu.trigger(:_refresh_) }

  Vedeu.configure do
    colour background: '#ff0000', foreground: '#00ff00'
    debug!
    height 10
    log Dir.tmpdir + '/vedeu.log'
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
      line 'Background is #ff0000'
      line 'Foreground is #00ff00'
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

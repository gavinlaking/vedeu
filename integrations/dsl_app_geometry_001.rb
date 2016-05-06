#!/usr/bin/env ruby

# frozen_string_literal: true

require 'bundler/setup'
require 'vedeu'

TESTCASE = 'dsl_app_geometry_001'

class DSLApp

  Vedeu.bind(:_initialize_) { Vedeu.trigger(:_refresh_) }

  Vedeu.configure do
    debug!
    log Dir.tmpdir + '/vedeu_views_dsl.log'
    renderers [
                Vedeu::Renderers::Terminal.new(
                  filename:   Dir.tmpdir + "/#{TESTCASE}.out",
                  write_file: true)
              ]
    run_once!
    standalone!

    height 12
    width  40
  end

  load File.dirname(__FILE__) + '/support/test_interface.rb'

  Vedeu.interface :geometry_interface do
    background '#ff3300'
    border do
      title 'Other'
      colour foreground: '#ff0000'
    end
    geometry do
      x  3
      y  3
      xn 13
      yn 4
    end
    zindex 2
  end

  Vedeu.render do
    view(:geometry_interface) do
      lines do
        2.times do
          line (" " * 10)
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

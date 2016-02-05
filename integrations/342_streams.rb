#!/usr/bin/env ruby

# frozen_string_literal: true

require 'bundler/setup'
require 'vedeu'

class DSLApp

  Vedeu.bind(:_initialize_) { Vedeu.trigger(:_refresh_) }

  Vedeu.configure do
    height 10
    debug!
    log '/tmp/vedeu_views_dsl.log'
    renderers(Vedeu::Renderers::Terminal.new(
                filename: '/tmp/342_streams.out',
                write_file: true))
    run_once!
    standalone!
  end

  Vedeu.interface :test1_interface do
    background '#000022'
    geometry do
      x  3
      y  3
      xn 53
      yn 3
    end
  end

  Vedeu.render do
    view(:test1_interface) do
      line do
        stream do
          foreground '#cc66ff'
          left '07/01/2016 21:32:19'
        end
        stream do
          foreground '#007777'
          left ' null'
        end
        stream do
          foreground '#dddddd'
          left ' > hi'
        end
      end
    end
  end

  def self.actual
    File.read('/tmp/342_streams.out')
  end

  def self.expected
    File.read(File.expand_path('../expected/342_streams.out', __FILE__))
  end

  def self.start(argv = ARGV)
    Vedeu::Launcher.execute!(argv)
  end

end # DSLApp

DSLApp.start

if DSLApp.expected == DSLApp.actual
  puts "#{__FILE__} \e[32mPassed.\e[39m"
  exit 0;
else
  puts "#{__FILE__} \e[31mFailed.\e[39m"
  exit 1;
end

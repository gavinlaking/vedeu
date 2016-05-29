#!/usr/bin/env ruby

# frozen_string_literal: true

require 'bundler/setup'
require 'vedeu'

TESTCASE = 'dsl_app_geometry_005'

class DSLApp

  Vedeu.bind(:_initialize_) { Vedeu.trigger(:_refresh_) }

  Vedeu.configure do
    debug!
    log Dir.tmpdir + '/vedeu.log'
    renderers [
                Vedeu::Renderers::Terminal.new(
                  filename:   Dir.tmpdir + "/#{TESTCASE}.out",
                  write_file: true)
              ]
    run_once!
    standalone!

    height 25
    width  80
  end

  Vedeu.interface :top_left_view do
    border do
      foreground '#f44336'
      title 'Top Left'
    end
    geometry do
      align vertical: :top, horizontal: :left, width: 20, height: 4
    end
  end

  Vedeu.interface :top_centre_view do
    border do
      foreground '#e91e63'
      title 'Top Centre'
    end
    geometry do
      align vertical: :top, horizontal: :centre, width: 20, height: 4
    end
  end

  Vedeu.interface :top_right_view do
    border do
      foreground '#9c27b0'
      title 'Top Right'
    end
    geometry do
      align vertical: :top, horizontal: :right, width: 20, height: 4
    end
  end

  Vedeu.interface :middle_left_view do
    border do
      foreground '#673ab7'
      title 'Middle Left'
    end
    geometry do
      align vertical: :middle, horizontal: :left, width: 20, height: 4
    end
  end

  Vedeu.interface :middle_centre_view do
    border do
      foreground '#3f51b5'
      title 'Middle Centre'
    end
    geometry do
      align vertical: :middle, horizontal: :centre, width: 20, height: 4
    end
  end

  Vedeu.interface :middle_right_view do
    border do
      foreground '#2196f3'
      title 'Middle Right'
    end
    geometry do
      align vertical: :middle, horizontal: :right, width: 20, height: 4
    end
  end

  Vedeu.interface :bottom_left_view do
    border do
      foreground '#03a9f4'
      title 'Bottom Left'
    end
    geometry do
      align vertical: :bottom, horizontal: :left, width: 20, height: 4
    end
  end

  Vedeu.interface :bottom_centre_view do
    border do
      foreground '#00bcd4'
      title 'Bottom Centre'
    end
    geometry do
      align vertical: :bottom, horizontal: :centre, width: 20, height: 4
    end
  end

  Vedeu.interface :bottom_right_view do
    border do
      foreground '#009688'
      title 'Bottom Right'
    end
    geometry do
      align vertical: :bottom, horizontal: :right, width: 20, height: 4
    end
  end

  Vedeu.render do
    view(:top_left_view) do
      lines do
        line "top left"
      end
    end

    view(:top_centre_view) do
      lines do
        line "top centre", align: :centre
      end
    end

    view(:top_right_view) do
      lines do
        line "top right", align: :right
      end
    end

    view(:middle_left_view) do
      lines do
        line "middle left"
      end
    end

    view(:middle_centre_view) do
      lines do
        line "middle centre", align: :centre
      end
    end

    view(:middle_right_view) do
      lines do
        line "middle right", align: :right
      end
    end

    view(:bottom_left_view) do
      lines do
        line "bottom left"
      end
    end

    view(:bottom_centre_view) do
      lines do
        line "bottom centre", align: :centre
      end
    end

    view(:bottom_right_view) do
      lines do
        line "bottom right", align: :right
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

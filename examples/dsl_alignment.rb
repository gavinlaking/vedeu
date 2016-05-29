#!/usr/bin/env ruby

# frozen_string_literal: true

require 'bundler/setup'
require 'vedeu'

class AlignmentApp

  Vedeu.bind(:_initialize_) { Vedeu.trigger(:_refresh_) }

  Vedeu.configure do
    debug!
    log Dir.tmpdir + '/vedeu.log'
    renderers [
                Vedeu::Renderers::Terminal.new,
                # Vedeu::Renderers::Text.new(
                #   filename: Dir.tmpdir + '/alignment.out'),
              ]
    run_once!
    standalone!
  end

  Vedeu.interface :top_left_view do
    border do
      title 'Top Left'
    end
    geometry do
      align vertical: :top, horizontal: :left, width: 20, height: 4
    end
  end

  Vedeu.interface :top_centre_view do
    border do
      title 'Top Centre'
    end
    geometry do
      align vertical: :top, horizontal: :centre, width: 20, height: 4
    end
  end

  Vedeu.interface :top_right_view do
    border do
      title 'Top Right'
    end
    geometry do
      align vertical: :top, horizontal: :right, width: 20, height: 4
    end
  end

  Vedeu.interface :middle_left_view do
    border do
      title 'Middle Left'
    end
    geometry do
      align vertical: :middle, horizontal: :left, width: 20, height: 4
    end
  end

  Vedeu.interface :middle_centre_view do
    border do
      title 'Middle Centre'
    end
    geometry do
      align vertical: :middle, horizontal: :centre, width: 20, height: 4
    end
  end

  Vedeu.interface :middle_right_view do
    border do
      title 'Middle Right'
    end
    geometry do
      align vertical: :middle, horizontal: :right, width: 20, height: 4
    end
  end

  Vedeu.interface :bottom_left_view do
    border do
      title 'Bottom Left'
    end
    geometry do
      align vertical: :bottom, horizontal: :left, width: 20, height: 4
    end
  end

  Vedeu.interface :bottom_centre_view do
    border do
      title 'Bottom Centre'
    end
    geometry do
      align vertical: :bottom, horizontal: :centre, width: 20, height: 4
    end
  end

  Vedeu.interface :bottom_right_view do
    border do
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
        line "top centre"
      end
    end

    view(:top_right_view) do
      lines do
        line "top right"
      end
    end

    view(:middle_left_view) do
      lines do
        line "middle left"
      end
    end

    view(:middle_centre_view) do
      lines do
        line "middle centre"
      end
    end

    view(:middle_right_view) do
      lines do
        line "middle right"
      end
    end

    view(:bottom_left_view) do
      lines do
        line "bottom left"
      end
    end

    view(:bottom_centre_view) do
      lines do
        line "bottom centre"
      end
    end

    view(:bottom_right_view) do
      lines do
        line "bottom right"
      end
    end
  end

  def self.start(argv = ARGV)
    Vedeu::Launcher.execute!(argv)
  end

end # AlignmentApp

AlignmentApp.start

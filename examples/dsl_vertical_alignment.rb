#!/usr/bin/env ruby

# frozen_string_literal: true

require 'bundler/setup'
require 'vedeu'

class VerticalAlignmentApp

  def self.geometry_stats(name)
    Vedeu.geometries.by_name(name)
  end
  def self.gl
    geometry_stats(:top_interface)
  end
  def self.gc
    geometry_stats(:middle_interface)
  end
  def self.gr
    geometry_stats(:bottom_interface)
  end

  class CentreVerticalAlignmentView
    def render
      Vedeu.render do
        view(:middle_interface) do
          lines do
            line "x:#{gc.x}, xn:#{gc.xn} (w:#{gc.width})"
            line "y:#{gc.y}, yn:#{gc.yn} (h:#{gc.height})"
            line ""
            line "bx:#{gc.bx}, bxn:#{gc.bxn} (bw:#{gc.width})"
            line "by:#{gc.by}, byn:#{gc.byn} (bh:#{gc.height})"
            line ""
            line "The 'h', 'j', 'k' and 'l' keys will"
            line "move this view left, down, up, and"
            line "right respectively."
          end
        end
      end

      Vedeu.trigger(:_refresh_view_, :middle_interface)
    end

    def gc
      Vedeu.geometries.by_name(:middle_interface)
    end
  end

  Vedeu.bind(:_initialize_) { Vedeu.trigger(:_refresh_) }

  Vedeu.configure do
    debug!
    log Dir.tmpdir + '/vedeu_vertical.log'
    renderers [
                Vedeu::Renderers::Terminal.new,
                # Vedeu::Renderers::Text.new(
                #   filename: Dir.tmpdir + '/vedeu_vertical.out'),
              ]
  end

  Vedeu.interface :top_interface do
    border do
      title 'Align: Top'
    end
    geometry do
      align_top 10

      # or you can use:
      # align_left 30

      width 30
    end
  end

  Vedeu.interface :middle_interface do
    border do
      title 'Align: Middle'
    end
    geometry do
      align_middle 15

      # or you can use:
      # align_centre 30

      width 40
    end
  end

  Vedeu.interface :bottom_interface do
    border do
      title 'Align: Bottom'
    end
    geometry do
      align_bottom 10

      # or you can use:
      # align_right 30

      width 30
    end
  end

  Vedeu.keymap '_global_' do
    key('q') { Vedeu.exit }

    key('h') {
      Vedeu.trigger(:_view_left_, :middle_interface)

      VerticalAlignmentApp::CentreVerticalAlignmentView.new.render
    }
    key('j') {
      Vedeu.trigger(:_view_down_, :middle_interface)

      VerticalAlignmentApp::CentreVerticalAlignmentView.new.render
    }
    key('k') {
      Vedeu.trigger(:_view_up_, :middle_interface)

      VerticalAlignmentApp::CentreVerticalAlignmentView.new.render
    }
    key('l') {
      Vedeu.trigger(:_view_right_, :middle_interface)

      VerticalAlignmentApp::CentreVerticalAlignmentView.new.render
    }

    key('1') {
      Vedeu.trigger(:_maximise_, :top_interface)
    }
    key('2') {
      Vedeu.trigger(:_unmaximise_, :top_interface)
    }
    key('3') {
      Vedeu.trigger(:_maximise_, :middle_interface)
      VerticalAlignmentApp::CentreVerticalAlignmentView.new.render
    }
    key('4') {
      Vedeu.trigger(:_unmaximise_, :middle_interface)
      VerticalAlignmentApp::CentreVerticalAlignmentView.new.render
    }
    key('5') {
      Vedeu.trigger(:_maximise_, :bottom_interface)
    }
    key('6') {
      Vedeu.trigger(:_unmaximise_, :bottom_interface)
    }
  end

  Vedeu.render do
    view(:top_interface) do
      lines do
        line "x:#{gl.x}, xn:#{gl.xn} (w:#{gl.width})"
        line "y:#{gl.y}, yn:#{gl.yn} (h:#{gl.height})"
        line ""
        line "bx:#{gl.bx}, bxn:#{gl.bxn} (bw:#{gl.width})"
        line "by:#{gl.by}, byn:#{gl.byn} (bh:#{gl.height})"
      end
    end

    view(:middle_interface) do
      lines do
        line "x:#{gc.x}, xn:#{gc.xn} (w:#{gc.width})"
        line "y:#{gc.y}, yn:#{gc.yn} (h:#{gc.height})"
        line ""
        line "bx:#{gc.bx}, bxn:#{gc.bxn} (bw:#{gc.width})"
        line "by:#{gc.by}, byn:#{gc.byn} (bh:#{gc.height})"
        line ""
        line "The 'h', 'j', 'k' and 'l' keys will"
        line "move this view left, down, up, and"
        line "right respectively. The coordinates"
        line "will not change in this example"
        line "because they have not been"
        line "instructed to do so."
      end
    end

    view(:bottom_interface) do
      lines do
        line "x:#{gr.x}, xn:#{gr.xn} (w:#{gr.width})"
        line "y:#{gr.y}, yn:#{gr.yn} (h:#{gr.height})"
        line ""
        line "bx:#{gr.bx}, bxn:#{gr.bxn} (bw:#{gr.width})"
        line "by:#{gr.by}, byn:#{gr.byn} (bh:#{gr.height})"
      end
    end
  end

  def self.start(argv = ARGV)
    Vedeu::Launcher.execute!(argv)
  end

end # VerticalAlignmentApp

VerticalAlignmentApp.start

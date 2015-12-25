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

  def self.border_stats(name)
    Vedeu.borders.by_name(name)
  end
  def self.bl
    border_stats(:top_interface)
  end
  def self.bc
    border_stats(:middle_interface)
  end
  def self.br
    border_stats(:bottom_interface)
  end

  class CentreVerticalAlignmentView
    def render
      Vedeu.render do
        view(:middle_interface) do
          lines do
            line "x:#{gc.x}, xn:#{gc.xn} (w:#{gc.width})"
            line "y:#{gc.y}, yn:#{gc.yn} (h:#{gc.height})"
            line ""
            line "bx:#{bc.bx}, bxn:#{bc.bxn} (bw:#{bc.width})"
            line "by:#{bc.by}, byn:#{bc.byn} (bh:#{bc.height})"
            line ""
            line "The 'h', 'j', 'k' and 'l' keys will"
            line "move this view left, down, up, and"
            line "right respectively."
          end
        end
      end

      Vedeu.trigger(:_refresh_view, :middle_interface)
    end

    def gc
      Vedeu.geometries.by_name(:middle_interface)
    end

    def bc
      Vedeu.borders.by_name(:middle_interface)
    end
  end

  Vedeu.bind(:_initialize_) { Vedeu.trigger(:_refresh_) }

  Vedeu.configure do
    log '/tmp/vertical_alignment.log'
    renderers Vedeu::Renderers::File.new(filename: '/tmp/vertical_alignment.out')
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
  end

  Vedeu.render do
    view(:top_interface) do
      lines do
        line "x:#{gl.x}, xn:#{gl.xn} (w:#{gl.width})"
        line "y:#{gl.y}, yn:#{gl.yn} (h:#{gl.height})"
        line ""
        line "bx:#{bl.bx}, bxn:#{bl.bxn} (bw:#{bl.width})"
        line "by:#{bl.by}, byn:#{bl.byn} (bh:#{bl.height})"
      end
    end

    view(:middle_interface) do
      lines do
        line "x:#{gc.x}, xn:#{gc.xn} (w:#{gc.width})"
        line "y:#{gc.y}, yn:#{gc.yn} (h:#{gc.height})"
        line ""
        line "bx:#{bc.bx}, bxn:#{bc.bxn} (bw:#{bc.width})"
        line "by:#{bc.by}, byn:#{bc.byn} (bh:#{bc.height})"
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
        line "bx:#{br.bx}, bxn:#{br.bxn} (bw:#{br.width})"
        line "by:#{br.by}, byn:#{br.byn} (bh:#{br.height})"
      end
    end
  end

  def self.start(argv = ARGV)
    Vedeu::Launcher.execute!(argv)
  end

end # VerticalAlignmentApp

VerticalAlignmentApp.start

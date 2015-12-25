#!/usr/bin/env ruby

# frozen_string_literal: true

require 'bundler/setup'
require 'vedeu'

class HorizontalAlignmentApp

  def self.geometry_stats(name)
    Vedeu.geometries.by_name(name)
  end
  def self.gl
    geometry_stats(:left_interface)
  end
  def self.gc
    geometry_stats(:centre_interface)
  end
  def self.gr
    geometry_stats(:right_interface)
  end

  def self.border_stats(name)
    Vedeu.borders.by_name(name)
  end
  def self.bl
    border_stats(:left_interface)
  end
  def self.bc
    border_stats(:centre_interface)
  end
  def self.br
    border_stats(:right_interface)
  end

  class CentreHorizontalAlignmentView
    def render
      Vedeu.render do
        view(:centre_interface) do
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

      Vedeu.trigger(:_refresh_view, :centre_interface)
    end

    def gc
      Vedeu.geometries.by_name(:centre_interface)
    end

    def bc
      Vedeu.borders.by_name(:centre_interface)
    end
  end

  Vedeu.bind(:_initialize_) { Vedeu.trigger(:_refresh_) }

  Vedeu.configure do
    log '/tmp/horizontal_alignment.log'
    renderers Vedeu::Renderers::File.new(filename: '/tmp/horizontal_alignment.out')
  end

  Vedeu.interface :left_interface do
    border do
      title 'Align: Left'
    end
    geometry do
      align_left 30
      height 10
    end
  end

  Vedeu.interface :centre_interface do
    border do
      title 'Align: Centre'
    end
    geometry do
      align_centre 40
      height 15
    end
  end

  Vedeu.interface :right_interface do
    border do
      title 'Align: Right'
    end
    geometry do
      align_right 30
      height 10
    end
  end

  Vedeu.keymap '_global_' do
    key('q') { Vedeu.exit }

    key('h') {
      Vedeu.trigger(:_view_left_, :centre_interface)

      HorizontalAlignmentApp::CentreHorizontalAlignmentView.new.render
    }
    key('j') {
      Vedeu.trigger(:_view_down_, :centre_interface)

      HorizontalAlignmentApp::CentreHorizontalAlignmentView.new.render
    }
    key('k') {
      Vedeu.trigger(:_view_up_, :centre_interface)

      HorizontalAlignmentApp::CentreHorizontalAlignmentView.new.render
    }
    key('l') {
      Vedeu.trigger(:_view_right_, :centre_interface)

      HorizontalAlignmentApp::CentreHorizontalAlignmentView.new.render
    }

    key('1') {
      Vedeu.trigger(:_maximise_, :left_interface)
    }
    key('2') {
      Vedeu.trigger(:_unmaximise_, :left_interface)
    }
    key('3') {
      Vedeu.trigger(:_maximise_, :centre_interface)
      HorizontalAlignmentApp::CentreHorizontalAlignmentView.new.render
    }
    key('4') {
      Vedeu.trigger(:_unmaximise_, :centre_interface)
      HorizontalAlignmentApp::CentreHorizontalAlignmentView.new.render
    }
    key('5') {
      Vedeu.trigger(:_maximise_, :right_interface)
    }
    key('6') {
      Vedeu.trigger(:_unmaximise_, :right_interface)
    }
  end

  Vedeu.render do
    view(:left_interface) do
      lines do
        line "x:#{gl.x}, xn:#{gl.xn} (w:#{gl.width})"
        line "y:#{gl.y}, yn:#{gl.yn} (h:#{gl.height})"
        line ""
        line "bx:#{bl.bx}, bxn:#{bl.bxn} (bw:#{bl.width})"
        line "by:#{bl.by}, byn:#{bl.byn} (bh:#{bl.height})"
      end
    end

    view(:centre_interface) do
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

    view(:right_interface) do
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

end # HorizontalAlignmentApp

HorizontalAlignmentApp.start

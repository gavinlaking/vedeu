#!/usr/bin/env ruby

require 'bundler/setup'
require 'vedeu'

class AlignmentApp

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

  Vedeu.bind(:_initialize_) { Vedeu.trigger(:_refresh_) }

  Vedeu.configure do
    log './tmp/alignment.log'
    renderers Vedeu::Renderers::File.new(filename: './tmp/alignment.out')
  end

  Vedeu.interface :left_interface do
    border do
      title 'Align: Left'
    end
    geometry do
      alignment :left, 30
      height 10
    end
  end

  Vedeu.interface :centre_interface do
    border do
      title 'Align: Centre'
    end
    geometry do
      alignment :centre, 30
      height 10
    end
  end

  Vedeu.interface :right_interface do
    border do
      title 'Align: Right'
    end
    geometry do
      alignment :right, 30
      height 10
    end
  end

  Vedeu.keymap '_global_' do
    key('q') { Vedeu.exit }
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

end # AlignmentApp

AlignmentApp.start

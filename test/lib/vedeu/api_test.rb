require 'test_helper'

module Vedeu

  describe API do

    it { Vedeu.must_respond_to(:background_colours) }
    it { Vedeu.must_respond_to(:borders) }
    it { Vedeu.must_respond_to(:buffers) }
    it { Vedeu.must_respond_to(:configure) }
    it { Vedeu.must_respond_to(:configuration) }
    it { Vedeu.must_respond_to(:cursor) }
    it { Vedeu.must_respond_to(:cursors) }
    it { Vedeu.must_respond_to(:border) }
    it { Vedeu.must_respond_to(:geometry) }
    it { Vedeu.must_respond_to(:group) }
    it { Vedeu.must_respond_to(:keymap) }
    it { Vedeu.must_respond_to(:interface) }
    it { Vedeu.must_respond_to(:renders) }
    it { Vedeu.must_respond_to(:render) }
    it { Vedeu.must_respond_to(:views) }
    it { Vedeu.must_respond_to(:bind) }
    it { Vedeu.must_respond_to(:bound?) }
    it { Vedeu.must_respond_to(:unbind) }
    it { Vedeu.must_respond_to(:events) }
    it { Vedeu.must_respond_to(:focus) }
    it { Vedeu.must_respond_to(:focus_by_name) }
    it { Vedeu.must_respond_to(:focussed?) }
    it { Vedeu.must_respond_to(:focus_next) }
    it { Vedeu.must_respond_to(:focus_previous) }
    it { Vedeu.must_respond_to(:foreground_colours) }
    it { Vedeu.must_respond_to(:geometries) }
    it { Vedeu.must_respond_to(:groups) }
    it { Vedeu.must_respond_to(:interfaces) }
    it { Vedeu.must_respond_to(:keymaps) }
    it { Vedeu.must_respond_to(:log) }
    it { Vedeu.must_respond_to(:log_stdout) }
    it { Vedeu.must_respond_to(:log_stderr) }
    it { Vedeu.must_respond_to(:keypress) }
    it { Vedeu.must_respond_to(:menu) }
    it { Vedeu.must_respond_to(:menus) }
    it { Vedeu.must_respond_to(:renderer) }
    it { Vedeu.must_respond_to(:renderers) }
    it { Vedeu.must_respond_to(:height) }
    it { Vedeu.must_respond_to(:width) }
    it { Vedeu.must_respond_to(:resize) }
    it { Vedeu.must_respond_to(:timer) }
    it { Vedeu.must_respond_to(:trigger) }
    it { Vedeu.must_respond_to(:exit) }
    it { Vedeu.must_respond_to(:clear) }
    it { Vedeu.must_respond_to(:clear_by_name) }
    it { Vedeu.must_respond_to(:clear_by_group) }
    it { Vedeu.must_respond_to(:hide_cursor) }
    it { Vedeu.must_respond_to(:show_cursor) }

  end # API

end # Vedeu

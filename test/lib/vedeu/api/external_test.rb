require 'test_helper'

module Vedeu

  module API

    describe External do

      it { Vedeu.must_respond_to(:bind) }
      it { Vedeu.must_respond_to(:bind_alias) }
      it { Vedeu.must_respond_to(:border) }
      it { Vedeu.must_respond_to(:bound?) }
      it { Vedeu.must_respond_to(:clear) }
      it { Vedeu.must_respond_to(:clear_by_group) }
      it { Vedeu.must_respond_to(:clear_by_name) }
      it { Vedeu.must_respond_to(:configuration) }
      it { Vedeu.must_respond_to(:configure) }
      it { Vedeu.must_respond_to(:cursor) }
      it { Vedeu.must_respond_to(:drb_restart) }
      it { Vedeu.must_respond_to(:drb_start) }
      it { Vedeu.must_respond_to(:drb_status) }
      it { Vedeu.must_respond_to(:drb_stop) }
      it { Vedeu.must_respond_to(:events) }
      it { Vedeu.must_respond_to(:exit) }
      it { Vedeu.must_respond_to(:focus) }
      it { Vedeu.must_respond_to(:focus_by_name) }
      it { Vedeu.must_respond_to(:focus_next) }
      it { Vedeu.must_respond_to(:focus_previous) }
      it { Vedeu.must_respond_to(:focussed?) }
      it { Vedeu.must_respond_to(:geometry) }
      it { Vedeu.must_respond_to(:goto) }
      it { Vedeu.must_respond_to(:group) }
      it { Vedeu.must_respond_to(:height) }
      it { Vedeu.must_respond_to(:hide_cursor) }
      it { Vedeu.must_respond_to(:hide_group) }
      it { Vedeu.must_respond_to(:hide_interface) }
      it { Vedeu.must_respond_to(:interface) }
      it { Vedeu.must_respond_to(:keymap) }
      it { Vedeu.must_respond_to(:keypress) }
      it { Vedeu.must_respond_to(:log) }
      it { Vedeu.must_respond_to(:log_stderr) }
      it { Vedeu.must_respond_to(:log_stdout) }
      it { Vedeu.must_respond_to(:menu) }
      it { Vedeu.must_respond_to(:render) }
      it { Vedeu.must_respond_to(:renders) }
      it { Vedeu.must_respond_to(:show_cursor) }
      it { Vedeu.must_respond_to(:show_group) }
      it { Vedeu.must_respond_to(:show_interface) }
      it { Vedeu.must_respond_to(:toggle_cursor) }
      it { Vedeu.must_respond_to(:toggle_group) }
      it { Vedeu.must_respond_to(:toggle_interface) }
      it { Vedeu.must_respond_to(:trigger) }
      it { Vedeu.must_respond_to(:unbind) }
      it { Vedeu.must_respond_to(:unbind_alias) }
      it { Vedeu.must_respond_to(:views) }
      it { Vedeu.must_respond_to(:width) }

    end # External

  end

end # Vedeu

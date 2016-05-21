# frozen_string_literal: true

require 'test_helper'

describe Vedeu do

  it { Vedeu.must_respond_to(:add_command) }
  it { Vedeu.must_respond_to(:add_keypress) }
  it { Vedeu.must_respond_to(:all_commands) }
  it { Vedeu.must_respond_to(:all_keypresses) }
  it { Vedeu.must_respond_to(:background_colours) }
  it { Vedeu.must_respond_to(:bind) }
  it { Vedeu.must_respond_to(:bind_alias) }
  it { Vedeu.must_respond_to(:border) }
  it { Vedeu.must_respond_to(:borders) }
  it { Vedeu.must_respond_to(:bound?) }
  it { Vedeu.must_respond_to(:buffers) }
  it { Vedeu.must_respond_to(:buffer_update) }
  it { Vedeu.must_respond_to(:buffer_write) }
  it { Vedeu.must_respond_to(:centre_x) }
  it { Vedeu.must_respond_to(:centre_y) }
  it { Vedeu.must_respond_to(:clear) }
  it { Vedeu.must_respond_to(:clear_by_group) }
  it { Vedeu.must_respond_to(:clear_by_name) }
  it { Vedeu.must_respond_to(:clear_content_by_name) }
  it { Vedeu.must_respond_to(:clock_time) }
  it { Vedeu.must_respond_to(:config) }
  it { Vedeu.must_respond_to(:configuration) }
  it { Vedeu.must_respond_to(:configure) }
  it { Vedeu.must_respond_to(:cursor) }
  it { Vedeu.must_respond_to(:cursors) }
  it { Vedeu.must_respond_to(:debug) }
  it { Vedeu.must_respond_to(:direct_write) }
  it { Vedeu.must_respond_to(:documents) }
  it { Vedeu.must_respond_to(:drb_restart) }
  it { Vedeu.must_respond_to(:drb_start) }
  it { Vedeu.must_respond_to(:drb_status) }
  it { Vedeu.must_respond_to(:drb_stop) }
  it { Vedeu.must_respond_to(:esc) }
  it { Vedeu.must_respond_to(:events) }
  it { Vedeu.must_respond_to(:exit) }
  it { Vedeu.must_respond_to(:focus) }
  it { Vedeu.must_respond_to(:focus?) }
  it { Vedeu.must_respond_to(:focus_by_name) }
  it { Vedeu.must_respond_to(:focus_next) }
  it { Vedeu.must_respond_to(:focus_previous) }
  it { Vedeu.must_respond_to(:focussed?) }
  it { Vedeu.must_respond_to(:foreground_colours) }
  it { Vedeu.must_respond_to(:geometries) }
  it { Vedeu.must_respond_to(:geometry) }
  it { Vedeu.must_respond_to(:goto) }
  it { Vedeu.must_respond_to(:group) }
  it { Vedeu.must_respond_to(:groups) }

  describe '.height' do
    before { Vedeu::Terminal.stubs(:size).returns([25, 40]) }

    it { Vedeu.must_respond_to(:height) }
    it { Vedeu.height.must_equal(25) }
  end

  it { Vedeu.must_respond_to(:hide_cursor) }
  it { Vedeu.must_respond_to(:hide_group) }
  it { Vedeu.must_respond_to(:hide_interface) }
  it { Vedeu.must_respond_to(:interface) }
  it { Vedeu.must_respond_to(:interfaces) }
  it { Vedeu.must_respond_to(:keymap) }
  it { Vedeu.must_respond_to(:keymaps) }
  it { Vedeu.must_respond_to(:keypress) }
  it { Vedeu.must_respond_to(:last_command) }
  it { Vedeu.must_respond_to(:last_keypress) }
  it { Vedeu.must_respond_to(:log) }
  it { Vedeu.must_respond_to(:log_stderr) }
  it { Vedeu.must_respond_to(:log_stdout) }
  it { Vedeu.must_respond_to(:log_timestamp) }
  it { Vedeu.must_respond_to(:menu) }
  it { Vedeu.must_respond_to(:menus) }
  it { Vedeu.must_respond_to(:profile) }
  it { Vedeu.must_respond_to(:read) }
  it { Vedeu.must_respond_to(:ready!) }
  it { Vedeu.must_respond_to(:ready?) }
  it { Vedeu.must_respond_to(:refresh) }
  it { Vedeu.must_respond_to(:render) }
  it { Vedeu.must_respond_to(:render_output) }
  it { Vedeu.must_respond_to(:renders) }
  it { Vedeu.must_respond_to(:renderers) }

  describe '.requires_gem!' do
    let(:gem_name) { 'vedeu' }

    subject { Vedeu.requires_gem!(gem_name) }

    context 'when the gem is available' do
      it { subject.must_equal(true) }
    end

    context 'when the gem is not available' do
      let(:gem_name) { 'some_unknown_gem' }

      it { proc { subject }.must_raise(Vedeu::Error::Fatal) }
    end
  end

  it { Vedeu.must_respond_to(:repositories) }
  it { Vedeu.must_respond_to(:resize) }
  it { Vedeu.must_respond_to(:show_cursor) }
  it { Vedeu.must_respond_to(:show_group) }
  it { Vedeu.must_respond_to(:show_interface) }
  it { Vedeu.must_respond_to(:timer) }
  it { Vedeu.must_respond_to(:toggle_cursor) }
  it { Vedeu.must_respond_to(:toggle_group) }
  it { Vedeu.must_respond_to(:toggle_interface) }
  it { Vedeu.must_respond_to(:trigger) }
  it { Vedeu.must_respond_to(:unbind) }
  it { Vedeu.must_respond_to(:unbind_alias) }
  it { Vedeu.must_respond_to(:views) }

  describe '.width' do
    before { Vedeu::Terminal.stubs(:size).returns([25, 40]) }

    it { Vedeu.must_respond_to(:width) }
    it { Vedeu.width.must_equal(40) }
  end

  it { Vedeu.must_respond_to(:write) }

end # Vedeu

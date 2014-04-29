require_relative '../../../test_helper'

module Vedeu
  module Colours
    describe Wrapper do
      let(:klass) { Wrapper }

      describe '.normal' do
        subject { klass.normal }

        it { subject.must_be_instance_of(Fixnum) }

        it { subject.must_equal(0) }
      end

      describe '.reverse' do
        subject { klass.reverse }

        it { subject.must_be_instance_of(Fixnum) }

        it { subject.must_equal(262144) }
      end

      describe '.black' do
        subject { klass.black }

        it { subject.must_be_instance_of(Fixnum) }

        it { subject.must_equal(0) }
      end

      describe '.blue' do
        subject { klass.blue }

        it { subject.must_be_instance_of(Fixnum) }

        it { subject.must_equal(4) }
      end

      describe '.cyan' do
        subject { klass.cyan }

        it { subject.must_be_instance_of(Fixnum) }

        it { subject.must_equal(6) }
      end

      describe '.green' do
        subject { klass.green }

        it { subject.must_be_instance_of(Fixnum) }

        it { subject.must_equal(2) }
      end

      describe '.magenta' do
        subject { klass.magenta }

        it { subject.must_be_instance_of(Fixnum) }

        it { subject.must_equal(5) }
      end

      describe '.red' do
        subject { klass.red }

        it { subject.must_be_instance_of(Fixnum) }

        it { subject.must_equal(1) }
      end

      describe '.white' do
        subject { klass.white }

        it { subject.must_be_instance_of(Fixnum) }

        it { subject.must_equal(7) }
      end

      describe '.yellow' do
        subject { klass.yellow }

        it { subject.must_be_instance_of(Fixnum) }

        it { subject.must_equal(3) }
      end

      describe '.enable_colours' do
        before  {}

        subject { klass.enable_colours }

        it { skip }

        # it { subject.must_be_instance_of(Fixnum) }

        # it { subject.must_equal() }
      end

      describe '.terminal_supports_colours?' do
        before  {}

        subject { klass.terminal_supports_colours? }

        it { skip }

        # it { subject.must_be_instance_of() }

        # it { subject.must_equal() }
      end

      describe '.columns' do
        before  {}

        subject { klass.columns }

        it { skip }

        # it { subject.must_be_instance_of(Fixnum) }

        # it { subject.must_equal(80) }
      end

      describe '.lines' do
        before  {}

        subject { klass.lines }

        it { skip }

        # it { subject.must_be_instance_of(Fixnum) }

        # it { subject.must_equal() }
      end

      describe '.delay' do
        subject { klass.delay }

        it { skip }

        # it { subject.must_be_instance_of(Fixnum) }

        # it { subject.must_equal(1) }
      end

      describe '.no_delay' do
        subject { klass.no_delay }

        it { skip }

        # it { subject.must_be_instance_of(Fixnum) }

        # it { subject.must_equal(1) }
      end

      describe '.set_position' do
        subject { klass.set_position }

        it { skip }

        # it { subject.must_be_instance_of() }

        # it { subject.must_equal() }
      end

      describe '.add_string' do
        subject { klass.add_string }

        it { skip }

        # it { subject.must_be_instance_of() }

        # it { subject.must_equal() }
      end

      describe '.hide_typed_characters' do
        subject { klass.hide_typed_characters }

        it { skip }

        # it { subject.must_be_instance_of() }

        # it { subject.must_equal() }
      end

      describe '.show_typed_characters' do
        subject { klass.show_typed_characters }

        it { skip }

        # it { subject.must_be_instance_of() }

        # it { subject.must_equal() }
      end

      describe '.new_line_translation_off' do
        subject { klass.new_line_translation_off }

        it { skip }

        # it { subject.must_be_instance_of() }

        # it { subject.must_equal() }
      end

      describe '.new_line_translation_on' do
        subject { klass.new_line_translation_on }

        it { skip }

        # it { subject.must_be_instance_of() }

        # it { subject.must_equal() }
      end

      describe '.enable_raw_mode' do
        subject { klass.enable_raw_mode }

        it { skip }

        # it { subject.must_be_instance_of() }

        # it { subject.must_equal() }
      end

      describe '.disable_raw_mode' do
        subject { klass.disable_raw_mode }

        it { skip }

        # it { subject.must_be_instance_of() }

        # it { subject.must_equal() }
      end

      describe '.open_screen' do
        subject { klass.open_screen }

        it { skip }

        # it { subject.must_be_instance_of(Curses::Window) }
      end

      describe '.close_screen' do
        subject { klass.close_screen }

        it { skip }

        # it { subject.must_be_instance_of() }

        # it { subject.must_equal() }
      end

      describe '.clear_screen' do
        before  { Curses.stubs(:clear).returns(nil) }

        subject { klass.clear_screen }

        it { skip }

        # it { subject.must_be_instance_of(NilClass) }
      end

      describe '.define_pair' do
        let(:id)         {}
        let(:foreground) {}
        let(:background) {}

        subject { klass.define_pair(id, foreground, background) }

        it { skip }

        # it { subject.must_be_instance_of() }

        # it { subject.must_equal() }
      end

      describe '.colour_pair' do
        let(:pair_id) { 2 }

        subject { klass.colour_pair(pair_id) }

        it { skip }

        # it { subject.must_be_instance_of(Fixnum) }

        # it { subject.must_equal(512) }
      end

      describe '.set_style' do
        let(:style) { 2 }

        subject { klass.set_style(style) }

        it { skip }

        # it { subject.must_be_instance_of(Fixnum) }

        # it { subject.must_equal(2) }
      end
    end
  end
end

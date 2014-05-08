require_relative '../../../test_helper'

module Vedeu
  describe Esc do
    let(:klass)    { Esc }

    describe '.bold' do
      subject { klass.bold }

      it { subject.must_be_instance_of(String) }

      it { subject.must_equal("\e[1m") }
    end

    describe '.clear' do
      subject { klass.clear }

      it { subject.must_be_instance_of(String) }

      it { subject.must_equal("\e[2J") }
    end

    describe '.esc' do
      subject { klass.esc }

      it { subject.must_be_instance_of(String) }

      it { subject.must_equal("\e[") }
    end

    describe '.hide_cursor' do
      subject { klass.hide_cursor }

      it { subject.must_be_instance_of(String) }

      it { subject.must_equal("\e[?25l") }
    end

    describe '.inverse' do
      subject { klass.inverse }

      it { subject.must_be_instance_of(String) }

      it { subject.must_equal("\e[7m") }
    end

    describe '.reset' do
      subject { klass.reset }

      it { subject.must_be_instance_of(String) }

      it { subject.must_equal("\e[0m") }
    end

    describe '.set_colour' do
      let(:fg) {}
      let(:bg) {}

      subject { klass.set_colour(fg, bg) }

      it { subject.must_be_instance_of(String) }

      it { subject.must_equal("\e[38;5;39m\e[48;5;49m") }
    end

    describe '.set_position' do
      let(:y) { 12 }
      let(:x) { 19 }

      subject { klass.set_position(y, x) }

      it { subject.must_be_instance_of(String) }

      it { subject.must_equal("\e[13;20H") }
    end

    describe '.show_cursor' do
      subject { klass.show_cursor }

      it { subject.must_be_instance_of(String) }

      it { subject.must_equal("\e[?25h") }
    end

    describe '.underline' do
      subject { klass.underline }

      it { subject.must_be_instance_of(String) }

      it { subject.must_equal("\e[4m") }
    end
  end
end

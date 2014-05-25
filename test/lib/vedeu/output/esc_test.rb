require_relative '../../../test_helper'

module Vedeu
  describe Esc do
    let(:described_class) { Esc }

    describe '.bold' do
      let(:subject) { described_class.bold }

      it { subject.must_be_instance_of(String) }

      it { subject.must_equal("\e[1m") }
    end

    describe '.clear' do
      let(:subject) { described_class.clear }

      it { subject.must_be_instance_of(String) }

      it { subject.must_equal("\e[2J") }
    end

    describe '.esc' do
      let(:subject) { described_class.esc }

      it { subject.must_be_instance_of(String) }

      it { subject.must_equal("\e[") }
    end

    describe '.hide_cursor' do
      let(:subject) { described_class.hide_cursor }

      it { subject.must_be_instance_of(String) }

      it { subject.must_equal("\e[?25l") }
    end

    describe '.inverse' do
      let(:subject) { described_class.inverse }

      it { subject.must_be_instance_of(String) }

      it { subject.must_equal("\e[7m") }
    end

    describe '.reset' do
      let(:subject) { described_class.reset }

      it { subject.must_be_instance_of(String) }

      it { subject.must_equal("\e[0m") }
    end

    describe '.show_cursor' do
      let(:subject) { described_class.show_cursor }

      it { subject.must_be_instance_of(String) }

      it { subject.must_equal("\e[?25h") }
    end

    describe '.underline' do
      let(:subject) { described_class.underline }

      it { subject.must_be_instance_of(String) }

      it { subject.must_equal("\e[4m") }
    end
  end
end

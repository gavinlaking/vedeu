require_relative '../../../test_helper'

module Vedeu
  describe Esc do
    let(:described_class)    { Esc }

    describe '.bold' do
      subject { described_class.bold }

      it { subject.must_be_instance_of(String) }

      it { subject.must_equal("\e[1m") }
    end

    describe '.clear' do
      subject { described_class.clear }

      it { subject.must_be_instance_of(String) }

      it { subject.must_equal("\e[2J") }
    end

    describe '.esc' do
      subject { described_class.esc }

      it { subject.must_be_instance_of(String) }

      it { subject.must_equal("\e[") }
    end

    describe '.hide_cursor' do
      subject { described_class.hide_cursor }

      it { subject.must_be_instance_of(String) }

      it { subject.must_equal("\e[?25l") }
    end

    describe '.inverse' do
      subject { described_class.inverse }

      it { subject.must_be_instance_of(String) }

      it { subject.must_equal("\e[7m") }
    end

    describe '.reset' do
      subject { described_class.reset }

      it { subject.must_be_instance_of(String) }

      it { subject.must_equal("\e[0m") }
    end

    describe '.show_cursor' do
      subject { described_class.show_cursor }

      it { subject.must_be_instance_of(String) }

      it { subject.must_equal("\e[?25h") }
    end

    describe '.underline' do
      subject { described_class.underline }

      it { subject.must_be_instance_of(String) }

      it { subject.must_equal("\e[4m") }
    end
  end
end

require_relative '../../../test_helper'

module Vedeu
  module Input
    describe Wrapper do
      let(:klass) { Wrapper }

      describe '.enable_arrow_keys' do
        subject { klass.enable_arrow_keys }

        it { subject.must_be_instance_of(TrueClass) }
      end

      describe '.disable_arrow_keys' do
        subject { klass.disable_arrow_keys }

        it { subject.must_be_instance_of(TrueClass) }
      end

      describe '.keypress' do
        subject { klass.keypress }

        it { skip }

        # it { subject.must_be_instance_of(String) }
      end

      describe '.press_up' do
        subject { klass.press_up }

        it { subject.must_be_instance_of(Fixnum) }

        it { subject.must_equal(259) }
      end

      describe '.press_down' do
        subject { klass.press_down }

        it { subject.must_be_instance_of(Fixnum) }

        it { subject.must_equal(258) }
      end

      describe '.press_left' do
        subject { klass.press_left }

        it { subject.must_be_instance_of(Fixnum) }

        it { subject.must_equal(260) }
      end

      describe '.press_right' do
        subject { klass.press_right }

        it { subject.must_be_instance_of(Fixnum) }

        it { subject.must_equal(261) }
      end

      describe '.press_end' do
        subject { klass.press_end }

        it { subject.must_be_instance_of(Fixnum) }

        it { subject.must_equal(360) }
      end

      describe '.press_home' do
        subject { klass.press_home }

        it { subject.must_be_instance_of(Fixnum) }

        it { subject.must_equal(262) }
      end

      describe '.press_page_down' do
        subject { klass.press_page_down }

        it { subject.must_be_instance_of(Fixnum) }

        it { subject.must_equal(338) }
      end

      describe '.press_page_up' do
        subject { klass.press_page_up }

        it { subject.must_be_instance_of(Fixnum) }

        it { subject.must_equal(339) }
      end

      describe '.press_insert' do
        subject { klass.press_insert }

        it { subject.must_be_instance_of(Fixnum) }

        it { subject.must_equal(331) }
      end

      describe 'press_fkeys' do
        subject { klass.press_fkeys }

        it { skip }
      end

      describe '.press_f0' do
        subject { klass.press_f0 }

        it { subject.must_be_instance_of(Fixnum) }

        it { subject.must_equal(264) }
      end

      describe '.press_delete' do
        subject { klass.press_delete }

        it { subject.must_be_instance_of(Fixnum) }

        it { subject.must_equal(330) }
      end

      describe '.press_resize' do
        subject { klass.press_resize }

        it { subject.must_be_instance_of(Fixnum) }

        it { subject.must_equal(410) }
      end
    end
  end
end

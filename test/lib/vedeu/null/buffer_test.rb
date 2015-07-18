require 'test_helper'

module Vedeu

  module Null

    describe Buffer do

      let(:described) { Vedeu::Null::Buffer }
      let(:instance)  { described.new(_name) }
      let(:_name)     { 'null_buffer' }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@name').must_equal(_name) }
      end

      describe '#clear' do
        subject { instance.clear }

        it { subject.must_be_instance_of(NilClass) }
      end

      describe '#hide' do
        subject { instance.hide }

        it { subject.must_be_instance_of(NilClass) }
      end

      describe '#null?' do
        subject { instance.null? }

        it { subject.must_be_instance_of(TrueClass) }
      end

      describe '#render' do
        subject { instance.render }

        it { subject.must_be_instance_of(NilClass) }
      end

      describe '#show' do
        subject { instance.show }

        it { subject.must_be_instance_of(NilClass) }
      end

      describe '#toggle' do
        subject { instance.toggle }

        it { subject.must_be_instance_of(NilClass) }
      end

    end # Buffer

  end # Null

end # Vedeu

require 'test_helper'

module Vedeu

  module Null

    describe Interface do

      let(:described) { Vedeu::Null::Interface }
      let(:instance)  { described.new(_name) }
      let(:_name)     {}

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@name').must_equal(_name) }
      end

      describe '#attributes' do
        subject { instance.attributes }

        it { subject.must_be_instance_of(Hash) }
      end

      describe '#store' do
        subject { instance.store }

        it { subject.must_be_instance_of(Vedeu::Null::Interface) }
      end

      describe '#visible?' do
        subject { instance.visible? }

        it { subject.must_be_instance_of(FalseClass) }
      end

      describe '#visible=' do
        subject { instance.visible=(:irrelevant) }

        # it { skip }
        # it { subject.must_be_instance_of(FalseClass) }
      end

    end # Interface

  end # Null

end # Vedeu

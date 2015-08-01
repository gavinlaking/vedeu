require 'test_helper'

module Vedeu

  module Views

    describe Composition do

      let(:described)  { Vedeu::Views::Composition }
      let(:instance)   { described.new(attributes) }
      let(:attributes) {
        {
          views: views,
          colour:     colour,
          style:      style,
        }
      }
      let(:views) { [] }
      let(:colour)     {}
      let(:style)      {}

      describe '.build' do
        subject {
          described.build({}) do
            # ...
          end
        }

        it { subject.must_be_instance_of(described) }
      end

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@views').must_equal(views) }
      end

      describe '#add' do
        let(:child) { Vedeu::Views::View.new }

        subject { instance.add(child) }

        it { subject.must_be_instance_of(Vedeu::Views::ViewCollection) }
      end

      describe '#views' do
        subject { instance.views }

        it { subject.must_be_instance_of(Vedeu::Views::ViewCollection) }
      end

      describe '#parent' do
        subject { instance.parent }

        it { subject.must_be_instance_of(NilClass) }
      end

    end # Composition

  end # Views

end # Vedeu

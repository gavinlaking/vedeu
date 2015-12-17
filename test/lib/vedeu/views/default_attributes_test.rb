require 'test_helper'

module Vedeu

  module Views

    class DefaultAttributesTest

      include Vedeu::Views::DefaultAttributes

    end # DefaultAttributesTest

    describe DefaultAttributes do

      let(:described) { Vedeu::Views::DefaultAttributes }
      let(:instance)  {}

      let(:including_described) { Vedeu::Views::DefaultAttributesTest }
      let(:including_instance)  { including_described.new }
      let(:model)               {}

      describe 'accessors' do
        it { including_instance.must_respond_to(:align) }
        it { including_instance.must_respond_to(:pad) }
        it { including_instance.must_respond_to(:truncate) }
        it { including_instance.must_respond_to(:width) }
        it { including_instance.must_respond_to(:wordwrap) }
      end

      describe '#attributes' do
        let(:expected) {
          {
            align:    Vedeu::Coercers::Alignment.new,
            pad:      ' ',
            truncate: false,
            width:    nil,
            wordwrap: false,
          }
        }

        subject { including_instance.attributes }

        it { subject.must_be_instance_of(Hash) }
        it { subject.must_equal(expected) }
      end

    end # DefaultAttributes

  end # Views

end # Vedeu

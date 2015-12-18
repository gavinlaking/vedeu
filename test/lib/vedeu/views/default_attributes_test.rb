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
        # it { including_instance.must_respond_to(:client) }
        # it { including_instance.must_respond_to(:colour) }
        # it { including_instance.must_respond_to(:name) }
        it { including_instance.must_respond_to(:pad) }
        # it { including_instance.must_respond_to(:parent) }
        # it { including_instance.must_respond_to(:style) }
        it { including_instance.must_respond_to(:truncate) }
        # it { including_instance.must_respond_to(:value) }
        it { including_instance.must_respond_to(:width) }
        it { including_instance.must_respond_to(:wordwrap) }
      end

      describe '#attributes' do
        let(:expected) {
          {
            align:    Vedeu::Coercers::Alignment.new,
            # client:   nil,
            # colour:   nil,
            # name:     nil,
            pad:      ' ',
            # parent:   nil,
            # style:    nil,
            truncate: false,
            # value:    '',
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

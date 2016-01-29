# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Views

    class DefaultAttributesTest

      include Vedeu::Views::DefaultAttributes

      def nil_for_testing_purposes
        nil
      end
      alias client nil_for_testing_purposes
      alias colour nil_for_testing_purposes
      alias name nil_for_testing_purposes
      alias parent nil_for_testing_purposes
      alias style nil_for_testing_purposes

    end # DefaultAttributesTest

    describe DefaultAttributes do

      let(:described) { Vedeu::Views::DefaultAttributes }
      let(:instance)  {}

      let(:included_described) { Vedeu::Views::DefaultAttributesTest }
      let(:included_instance)  { included_described.new }
      let(:model)              {}

      describe '#align' do
        it { included_instance.must_respond_to(:align) }
      end

      describe '#client' do
        it { included_instance.must_respond_to(:client) }
      end

      describe '#colour' do
        it { included_instance.must_respond_to(:colour) }
      end

      describe '#name' do
        it { included_instance.must_respond_to(:name) }
      end

      describe '#pad' do
        it { included_instance.must_respond_to(:pad) }
      end

      describe '#parent' do
        it { included_instance.must_respond_to(:parent) }
      end

      describe '#style' do
        it { included_instance.must_respond_to(:style) }
      end

      describe '#truncate' do
        it { included_instance.must_respond_to(:truncate) }
      end

      describe '#truncate?' do
        it { included_instance.must_respond_to(:truncate?) }
      end

      describe '#width' do
        it { included_instance.must_respond_to(:width) }
      end

      describe '#wordwrap' do
        it { included_instance.must_respond_to(:wordwrap) }
      end

      describe '#wordwrap?' do
        it { included_instance.must_respond_to(:wordwrap?) }
      end

      describe '#attributes' do
        let(:expected) {
          {
            align:    nil,
            client:   nil,
            colour:   nil,
            name:     nil,
            pad:      ' ',
            parent:   nil,
            style:    nil,
            truncate: false,
            width:    nil,
            wordwrap: true,
          }
        }

        subject { included_instance.attributes }

        it { subject.must_be_instance_of(Hash) }
        it { subject.must_equal(expected) }
      end

    end # DefaultAttributes

  end # Views

end # Vedeu

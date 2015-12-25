# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Views

    class DefaultAttributesTest

      include Vedeu::Views::DefaultAttributes

      def nil_for_testing_purposes
        nil
      end
      alias_method :client, :nil_for_testing_purposes
      alias_method :colour, :nil_for_testing_purposes
      alias_method :name, :nil_for_testing_purposes
      alias_method :parent, :nil_for_testing_purposes
      alias_method :style, :nil_for_testing_purposes

    end # DefaultAttributesTest

    describe DefaultAttributes do

      let(:described) { Vedeu::Views::DefaultAttributes }
      let(:instance)  {}

      let(:including_described) { Vedeu::Views::DefaultAttributesTest }
      let(:including_instance)  { including_described.new }
      let(:model)               {}

      describe '#align' do
        it { including_instance.must_respond_to(:align) }
      end

      describe '#client' do
        it { including_instance.must_respond_to(:client) }
      end

      describe '#colour' do
        it { including_instance.must_respond_to(:colour) }
      end

      describe '#name' do
        it { including_instance.must_respond_to(:name) }
      end

      describe '#pad' do
        it { including_instance.must_respond_to(:pad) }
      end

      describe '#parent' do
        it { including_instance.must_respond_to(:parent) }
      end

      describe '#style' do
        it { including_instance.must_respond_to(:style) }
      end

      describe '#truncate' do
        it { including_instance.must_respond_to(:truncate) }
      end

      describe '#width' do
        it { including_instance.must_respond_to(:width) }
      end

      describe '#wordwrap' do
        it { including_instance.must_respond_to(:wordwrap) }
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

# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Views

    class ValueTestClass

      include Vedeu::Views::Value

    end # ValueTestClass

    describe Value do

      let(:described) { Vedeu::Views::Value }
      let(:included_described) { Vedeu::Views::ValueTestClass }
      let(:included_instance)  { included_described.new }

      describe '.collection' do
        it { included_described.must_respond_to(:collection) }
      end

      describe '.deputy' do
        it { included_described.must_respond_to(:collection) }
      end

      describe '.entity' do
        it { included_described.must_respond_to(:entity) }
      end

      describe '.included' do
        subject { described.included(included_described) }

        it { subject.must_be_instance_of(Class) }
      end

      describe '.parent' do
        it { included_described.must_respond_to(:parent) }
      end

      describe '#add' do
        let(:child) {}

        subject { included_instance.add(child) }

        # @todo Add more tests.
        # it { skip }
      end

      describe '#<<' do
        it { included_instance.must_respond_to(:<<) }
      end

      describe '#client' do
        subject { included_instance.client }

        it { subject.must_equal(nil) }
      end

      describe '#client?' do
        subject { included_instance.client? }
      end

      describe '#collection' do
        subject { included_instance.collection }

        it { subject.must_equal(nil) }
      end

      describe '#deputy' do
        subject { included_instance.deputy }

        # @todo Add more tests.
      end

      describe '#entity' do
        subject { included_instance.entity }

        it { subject.must_equal(nil) }
      end

      describe '#parent' do
        subject { included_instance.parent }

        context 'when the parent attribute is set' do
          # it { subject.must_equal() }
        end

        context 'when the parent attribute is not set' do
          it { subject.must_equal(nil) }
        end
      end

      describe '#value' do
        subject { included_instance.value }

        # @todo Add more tests.
      end

      describe '#value=' do
        let(:_value) {}

        subject { included_instance.value=(_value) }

        # @todo Add more tests.
      end

      describe '#value?' do
        subject { included_instance.value? }

        # @todo Add more tests.
      end

    end # Value

  end # Views

end # Vedeu

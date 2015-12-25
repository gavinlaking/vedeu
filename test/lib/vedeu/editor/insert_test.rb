# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Editor

    describe Insert do

      let(:described)  { Vedeu::Editor::Insert }
      let(:instance)   { described.new(collection, entity, index, size) }
      let(:collection) {}
      let(:entity)     {}
      let(:index)      {}
      let(:size)       {}

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@collection').must_equal(collection) }
        it { instance.instance_variable_get('@entity').must_equal(entity) }
        it { instance.instance_variable_get('@index').must_equal(index) }
        it { instance.instance_variable_get('@size').must_equal(size) }
      end

      describe '.into' do
        subject { described.into(collection, entity, index, size) }
      end

      describe '#insert' do
        it { instance.must_respond_to(:insert) }
      end

    end # Insert

  end # Editor

end # Vedeu

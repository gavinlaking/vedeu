# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Editor

    class CollectionTestClass

      include Enumerable
      include Vedeu::Editor::Collection

      attr_accessor :collection

      def initialize(collection)
        @collection = collection
      end

    end # CollectionTestClass

    describe Collection do

      let(:described)          { Vedeu::Editor::Collection }
      let(:included_described) { Vedeu::Editor::CollectionTestClass }
      let(:included_instance)  { included_described.new(collection) }
      let(:collection)         { 'Some text...'.chars }

      describe '#by_index' do
        let(:index) { 0 }

        subject { included_instance.by_index(index) }

        it { subject.must_be_instance_of(String) }
      end

    end # Collection

  end # Editor

end # Vedeu

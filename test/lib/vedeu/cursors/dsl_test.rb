# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Cursors

    class DSLTestClass

      include Vedeu::Cursors::DSL

      attr_accessor :cursor_visible

      def model
        self
      end

      def name
        :actinium
      end

    end # DSLTestClass

    describe DSL do

      let(:described)          { Vedeu::Cursors::DSL }
      let(:included_described) { Vedeu::Cursors::DSLTestClass }
      let(:included_instance)  { included_described.new }

      describe '#cursor' do
        it { included_instance.must_respond_to(:cursor) }
      end

      describe '#cursor!' do
        it { included_instance.must_respond_to(:cursor!) }
      end

      describe '#show_cursor!' do
        it { included_instance.must_respond_to(:show_cursor!) }
      end

      describe '#no_cursor!' do
        it { included_instance.must_respond_to(:no_cursor!) }
      end

      describe '#hide_cursor!' do
        it { included_instance.must_respond_to(:hide_cursor!) }
      end

      # describe '#cursor' do
      #   let(:_value) {}
      #   let(:cursor) { Vedeu::Cursors::Cursor.new(name: :actinium) }

      #   before do
      #     Vedeu.cursors.reset!
      #     Vedeu.cursors.stubs(:by_name).returns(cursor)
      #   end

      #   subject { included_instance.cursor(_value) }

      #   it do
      #     subject
      #     Vedeu.cursors.by_name(:actinium).visible?.must_equal(false)
      #   end

      #   context 'when the value is false' do
      #     let(:_value) { false }

      #     it do
      #       subject
      #       Vedeu.cursors.by_name(:actinium).visible?.must_equal(false)
      #     end
      #   end

      #   context 'when the value is nil' do
      #     let(:_value) {}

      #     it do
      #       subject
      #       Vedeu.cursors.by_name(:actinium).visible?.must_equal(false)
      #     end
      #   end

      #   context 'when the value is :show' do
      #     let(:_value) { :show }

      #     it do
      #       subject
      #       Vedeu.cursors.by_name(:actinium).visible?.must_equal(true)
      #     end
      #   end

      #   context 'when the value is true' do
      #     let(:_value) { true }

      #     it do
      #       subject
      #       Vedeu.cursors.by_name(:actinium).visible?.must_equal(true)
      #     end
      #   end

      #   context 'when the value is :yes' do
      #     let(:_value) { :yes }

      #     it do
      #       subject
      #       Vedeu.cursors.by_name(:actinium).visible?.must_equal(true)
      #     end
      #   end
      # end

      describe '#cursor!' do
        subject { included_instance.cursor! }

        it do
          subject
          Vedeu.cursors.by_name(:actinium).visible?.must_equal(true)
        end
      end

      describe '#no_cursor!' do
        subject { included_instance.no_cursor! }

        it do
          subject
          Vedeu.cursors.by_name(:actinium).visible?.must_equal(false)
        end
      end

    end # DSL

  end # Cursors

end # Vedeu

# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Buffers

    describe Clear do

      let(:described)  { Vedeu::Buffers::Clear }
      let(:instance)   { described.new(attributes) }
      let(:attributes) {
        {
          height: height,
          name:   _name,
          width:  width,
        }
      }
      let(:height) { 4 }
      let(:_name)  { :vedeu_buffers_empty }
      let(:width)  { 9 }

      let(:term_height) { 8 }
      let(:term_width)  { 15 }

      before do
        Vedeu.stubs(:height).returns(term_height)
        Vedeu.stubs(:width).returns(term_width)
      end

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }

        context 'when the height is given' do
          it { instance.instance_variable_get('@height').must_equal(height) }
        end

        context 'when the height not is given' do
          let(:height) {}

          it do
            instance.instance_variable_get('@height').must_equal(term_height)
          end
        end

        it { instance.instance_variable_get('@name').must_equal(_name) }

        context 'when the width is given' do
          it { instance.instance_variable_get('@width').must_equal(width) }
        end

        context 'when the width not is given' do
          let(:width) {}

          it { instance.instance_variable_get('@width').must_equal(term_width) }
        end
      end

      describe '#buffer' do
        subject { instance.buffer }

        it { subject.must_be_instance_of(Array) }
        it { subject.first.must_be_instance_of(Array) }
        it { subject.first.first.must_be_instance_of(Vedeu::Cells::Clear) }

        it { subject.size.must_equal(height + 1) }
        it { subject.first.size.must_equal(width + 1) }
      end

      describe '#height' do
        it { instance.must_respond_to(:height) }
      end

      describe '#name' do
        it { instance.must_respond_to(:name) }
      end

      describe '#width' do
        it { instance.must_respond_to(:width) }
      end

    end # Clear

  end # Buffers

end # Vedeu

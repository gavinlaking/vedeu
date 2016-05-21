# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Buffers

    describe Empty do

      let(:described)  { Vedeu::Buffers::Empty }
      let(:instance)   { described.new(attributes) }
      let(:attributes) {
        {
          height: height,
          name:   _name,
          width:  width,
          x:      x,
          y:      y,
        }
      }
      let(:height) { 4 }
      let(:_name)  { :vedeu_buffers_empty }
      let(:width)  { 9 }
      let(:x)      { 3 }
      let(:y)      { 2 }

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

        context 'when x is given' do
          it { instance.instance_variable_get('@x').must_equal(x) }
        end

        context 'when x not is given' do
          let(:x) {}

          it { instance.instance_variable_get('@x').must_equal(1) }
        end

        context 'when y is given' do
          it { instance.instance_variable_get('@y').must_equal(y) }
        end

        context 'when y not is given' do
          let(:y) {}

          it { instance.instance_variable_get('@y').must_equal(1) }
        end
      end

      describe '#buffer' do
        subject { instance.buffer }

        it { subject.must_be_instance_of(Array) }
        it { subject.first.must_be_instance_of(Array) }
        it { subject.first.first.must_be_instance_of(Vedeu::Cells::Empty) }

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

      describe '#x' do
        it { instance.must_respond_to(:x) }
      end

      describe '#y' do
        it { instance.must_respond_to(:y) }
      end

    end # Empty

  end # Buffers

end # Vedeu

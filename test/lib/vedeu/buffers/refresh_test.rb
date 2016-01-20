# frozen_string_literal: true

require 'test_helper'

module Vedeu

  describe 'Bindings' do
    it { Vedeu.bound?(:_refresh_view_).must_equal(true) }
    it { Vedeu.bound?(:_refresh_view_content_).must_equal(true) }
  end

  module Buffers

    describe Refresh do

      let(:described) { Vedeu::Buffers::Refresh }
      let(:instance)  { described.new(_name, options) }
      let(:_name)     { :vedeu_buffers_refresh }
      let(:options)   {
        {
          content_only: content_only,
        }
      }
      let(:content_only) { false }
      let(:ready)        { true }
      let(:buffer)       { mock('Vedeu::Buffers::Buffer', render: nil) }

      before do
        Vedeu.stubs(:trigger).with(:_clear_view_content_, _name)
        Vedeu.stubs(:trigger).with(:_refresh_border_, _name)
      end

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@name').must_equal(_name) }
        it { instance.instance_variable_get('@options').must_equal(options) }
      end

      describe '.by_name' do
        before do
          Vedeu.buffers.stubs(:by_name).with(_name).returns(buffer)
        end

        subject { described.by_name(_name) }

        it do
          Vedeu.expects(:trigger).with(:_clear_view_content_, _name)
          subject
        end

        it do
          Vedeu.buffers.expects(:by_name).with(_name).returns(buffer)
          subject
        end

        it do
          Vedeu.expects(:trigger).with(:_refresh_border_, _name)
          subject
        end
      end

      describe '.refresh_content_by_name' do
        let(:content_only) { true }

        before do
          Vedeu.buffers.stubs(:by_name).with(_name).returns(buffer)
        end

        subject { described.refresh_content_by_name(_name) }

        it do
          Vedeu.expects(:trigger).with(:_clear_view_content_, _name)
          subject
        end

        it do
          Vedeu.buffers.expects(:by_name).with(_name).returns(buffer)
          subject
        end
      end

      describe '#by_name' do
        it { instance.must_respond_to(:by_name) }
      end

    end # Refresh

  end # Buffers

end # Vedeu

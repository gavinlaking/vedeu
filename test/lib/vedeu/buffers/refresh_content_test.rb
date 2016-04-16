# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Buffers

    describe RefreshContent do

      let(:described) { Vedeu::Buffers::RefreshContent }
      let(:instance)  { described.new(_name) }
      let(:_name)     { :vedeu_buffers_refresh }
      let(:ready)     { true }
      let(:buffer)    { mock('Vedeu::Buffers::Buffer', render: nil) }

      before do
        Vedeu.stubs(:clear_content_by_name).with(_name)
        Vedeu.stubs(:trigger).with(:_refresh_border_, _name)
      end

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@name').must_equal(_name) }
      end

      describe '.by_name' do
        before do
          Vedeu.buffers.stubs(:by_name).with(_name).returns(buffer)
        end

        subject { described.by_name(_name) }

        it do
          Vedeu.expects(:clear_content_by_name).with(_name)
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

    end # RefreshContent

  end # Buffers

end # Vedeu

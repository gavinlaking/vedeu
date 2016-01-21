# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Interfaces

    describe Interface do

      let(:described)  { Vedeu::Interfaces::Interface }
      let(:instance)   { described.new(attributes) }
      let(:attributes) {
        {
          client:         client,
          colour:         colour,
          cursor_visible: cursor_visible,
          delay:          delay,
          editable:       editable,
          group:          group,
          name:           _name,
          parent:         parent,
          style:          style,
          visible:        visible,
          zindex:         zindex,
        }
      }
      let(:client)         {}
      let(:colour)         {}
      let(:cursor_visible) { true }
      let(:delay)          { 0.0 }
      let(:editable)       { false }
      let(:group)          { '' }
      let(:_name)          { :vedeu_interfaces_interface }
      let(:parent)         {}
      let(:repository)     { Vedeu.interfaces }
      let(:style)          {}
      let(:visible)        { true }
      let(:zindex)         { 1 }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@client').must_equal(client) }
        it do
          instance.instance_variable_get('@cursor_visible').
            must_equal(cursor_visible)
        end
        it { instance.instance_variable_get('@delay').must_equal(delay) }
        it { instance.instance_variable_get('@editable').must_equal(editable) }
        it { instance.instance_variable_get('@group').must_equal(group) }
        it { instance.instance_variable_get('@name').must_equal(_name) }
        it { instance.instance_variable_get('@parent').must_equal(parent) }
        it do
          instance.instance_variable_get('@repository').must_equal(repository)
        end
        it { instance.instance_variable_get('@visible').must_equal(visible) }
        it { instance.instance_variable_get('@zindex').must_equal(zindex) }
      end

      describe '#client' do
        it { instance.must_respond_to(:client) }
      end

      describe '#client=' do
        it { instance.must_respond_to(:client=) }
      end

      describe '#cursor_visible' do
        it { instance.must_respond_to(:cursor_visible) }
      end

      describe '#cursor_visible=' do
        it { instance.must_respond_to(:cursor_visible=) }
      end

      describe '#delay' do
        it { instance.must_respond_to(:delay) }
      end

      describe '#delay=' do
        it { instance.must_respond_to(:delay=) }
      end

      describe '#editable' do
        it { instance.must_respond_to(:editable) }
      end

      describe '#editable=' do
        it { instance.must_respond_to(:editable=) }
      end

      describe '#editable?' do
        it { instance.must_respond_to(:editable?) }
      end

      describe '#group' do
        it { instance.must_respond_to(:group) }
      end

      describe '#group=' do
        it { instance.must_respond_to(:group=) }
      end

      describe '#name' do
        it { instance.must_respond_to(:name) }
      end

      describe '#name=' do
        it { instance.must_respond_to(:name=) }
      end

      describe '#parent' do
        it { instance.must_respond_to(:parent) }
      end

      describe '#parent=' do
        it { instance.must_respond_to(:parent=) }
      end

      describe '#zindex' do
        it { instance.must_respond_to(:zindex) }
      end

      describe '#zindex=' do
        it { instance.must_respond_to(:zindex=) }
      end

      describe '#visible' do
        it { instance.must_respond_to(:visible) }
      end

      describe '#visible=' do
        it { instance.must_respond_to(:visible=) }
      end

      describe '#visible?' do
        it { instance.must_respond_to(:visible?) }
      end

      describe '#attributes' do
        subject { instance.attributes }

        it { subject.must_be_instance_of(Hash) }
      end

      describe '#deputy' do
        subject { instance.deputy }

        it 'returns the DSL instance' do
          subject.must_be_instance_of(Vedeu::Interfaces::DSL)
        end
      end

      describe '#hide' do
        before { Vedeu.stubs(:trigger) }

        subject { instance.hide }

        it do
          Vedeu.expects(:trigger).with(:_clear_view_, _name)
          subject
        end
      end

      describe '#show' do
        before { Vedeu.stubs(:trigger) }

        subject { instance.show }

        it do
          Vedeu.expects(:trigger).with(:_refresh_view_, _name)
          subject
        end
      end

    end # Interface

  end # Interfaces

  describe 'Bindings' do
    it { Vedeu.bound?(:_hide_interface_).must_equal(true) }
    it { Vedeu.bound?(:_show_interface_).must_equal(true) }
    it { Vedeu.bound?(:_toggle_interface_).must_equal(true) }
    # it { Vedeu.bound?(:_hide_view_).must_equal(true) }
    # it { Vedeu.bound?(:_show_view_).must_equal(true) }
    # it { Vedeu.bound?(:_toggle_view_).must_equal(true) }
  end

end # Vedeu

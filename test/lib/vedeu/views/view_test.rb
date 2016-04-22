# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Views

    describe View do

      let(:described)  { Vedeu::Views::View }
      let(:instance)   { described.new(attributes) }
      let(:attributes) {
        {
          client:         client,
          colour:         colour,
          cursor_visible: cursor_visible,
          name:           _name,
          parent:         parent,
          style:          style,
          value:          _value,
          zindex:         zindex,
        }
      }
      let(:client)         {}
      let(:colour)         {}
      let(:cursor_visible) {}
      let(:_name)          { :vedeu_views_view }
      let(:parent)         {}
      let(:style)          {}
      let(:_value)         {}
      let(:zindex)         {}

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@client').must_equal(client) }
        it { instance.instance_variable_get('@colour').must_equal(colour) }
        it do
          instance.instance_variable_get('@cursor_visible')
            .must_equal(cursor_visible)
        end
        it { instance.instance_variable_get('@name').must_equal(_name) }
        it { instance.instance_variable_get('@parent').must_equal(parent) }
        it { instance.instance_variable_get('@style').must_equal(style) }
        it { instance.instance_variable_get('@value').must_equal(_value) }
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

      describe '#name=' do
        it { instance.must_respond_to(:name=) }
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

      describe '#attributes' do
        subject { instance.attributes }

        it { subject.must_be_instance_of(Hash) }
      end

      describe '#update_buffer' do
        let(:refresh) {}

        before { Vedeu.stubs(:trigger) }

        subject { instance.update_buffer(refresh) }

        context 'when the name attribute is defined' do
          it { subject.must_be_instance_of(described) }
        end

        context 'when the name attribute is not defined' do
          let(:_name) {}

          it { proc { subject }.must_raise(Vedeu::Error::MissingRequired) }
        end
      end

      describe '#visible?' do
        subject { instance.visible? }

        context 'when the interface is visible' do
          let(:interface) { Vedeu::Interfaces::Interface.new(visible: true) }

          before do
            Vedeu.interfaces.stubs(:by_name).with(_name).returns(interface)
          end

          it { subject.must_equal(true) }
        end

        context 'when the interface is not visible' do
          it { subject.must_equal(false) }
        end
      end

    end # Views

  end # Views

end # Vedeu

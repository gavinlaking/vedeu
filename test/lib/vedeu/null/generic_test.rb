# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Null

    describe Generic do

      let(:described) { Vedeu::Null::Generic }
      let(:instance)  { described.new(attributes) }
      let(:attributes){
        {
          name: _name
        }
      }
      let(:_name) { :vedeu_null_generic }

      describe '#name' do
        it { instance.must_respond_to(:name) }
      end

      describe '#attributes' do
        it { instance.must_respond_to(:attributes) }
      end

      describe '#visible?' do
        it { instance.must_respond_to(:visible?) }
      end

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it do
          instance.instance_variable_get('@attributes').must_equal(attributes)
        end

        context 'when a name is given' do
          it { instance.instance_variable_get('@name').must_equal(_name) }
        end

        context 'when a name is not given' do
          let(:attributes) { {} }

          it { instance.instance_variable_get('@name').must_equal('') }
        end
      end

      describe '#falsy' do
        subject { instance.falsy }

        it { subject.must_be_instance_of(FalseClass) }
      end

      describe '#enabled?' do
        it { instance.must_respond_to(:enabled?) }
      end

      describe '#maximise' do
        it { instance.must_respond_to(:maximise) }
      end

      describe '#maximised?' do
        it { instance.must_respond_to(:maximised?) }
      end

      describe '#unmaximise' do
        it { instance.must_respond_to(:unmaximise) }
      end

      describe '#visible' do
        it { instance.must_respond_to(:visible) }
      end

      describe '#visible?' do
        it { instance.must_respond_to(:visible?) }
      end

      describe '#editable?' do
        it { instance.must_respond_to(:editable?) }
      end

      describe '#null' do
        subject { instance.null }

        it { subject.must_be_instance_of(NilClass) }
      end

      describe '#add' do
        it { instance.must_respond_to(:add) }
      end

      describe '#bottom_item' do
        it { instance.must_respond_to(:bottom_item) }
      end

      describe '#clear' do
        it { instance.must_respond_to(:clear) }
      end

      describe '#colour' do
        it { instance.must_respond_to(:colour) }
      end

      describe '#current_item' do
        it { instance.must_respond_to(:current_item) }
      end

      describe '#deselect_item' do
        it { instance.must_respond_to(:deselect_item) }
      end

      describe '#hide' do
        it { instance.must_respond_to(:hide) }
      end

      describe '#item' do
        it { instance.must_respond_to(:item) }
      end

      describe '#items' do
        it { instance.must_respond_to(:items) }
      end

      describe '#next_item' do
        it { instance.must_respond_to(:next_item) }
      end

      describe '#parent' do
        it { instance.must_respond_to(:parent) }
      end

      describe '#prev_item' do
        it { instance.must_respond_to(:prev_item) }
      end

      describe '#render' do
        it { instance.must_respond_to(:render) }
      end

      describe '#select_item' do
        it { instance.must_respond_to(:select_item) }
      end

      describe '#selected_item' do
        it { instance.must_respond_to(:selected_item) }
      end

      describe '#show' do
        it { instance.must_respond_to(:show) }
      end

      describe '#style' do
        it { instance.must_respond_to(:style) }
      end

      describe '#toggle' do
        it { instance.must_respond_to(:toggle) }
      end

      describe '#top_item' do
        it { instance.must_respond_to(:top_item) }
      end

      describe '#view' do
        it { instance.must_respond_to(:view) }
      end

      describe '#zindex' do
        it { instance.must_respond_to(:zindex) }
      end

      describe '#null?' do
        subject { instance.null? }

        it { subject.must_be_instance_of(TrueClass) }
      end

      describe '#store' do
        subject { instance.store }

        it { subject.must_be_instance_of(described) }
      end

      describe '#visible=' do
        let(:_value) { :ignored }

        subject { instance.visible = (_value) }

        # This should be FalseClass, I'm explicitly returning false in the method.
        it { subject.must_be_instance_of(Symbol) }
      end

    end # Generic

  end # Null

end # Vedeu

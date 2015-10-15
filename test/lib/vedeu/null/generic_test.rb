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
      let(:_name) { 'null_generic' }

      describe 'alias methods' do
        it { instance.must_respond_to(:name) }
        it { instance.must_respond_to(:attributes) }
        it { instance.must_respond_to(:visible?) }
      end

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it {
          instance.instance_variable_get('@attributes').must_equal(attributes)
        }

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

        it { instance.must_respond_to(:centred) }
        it { instance.must_respond_to(:maximise) }
        it { instance.must_respond_to(:maximised?) }
        it { instance.must_respond_to(:unmaximise) }
        it { instance.must_respond_to(:visible) }
        it { instance.must_respond_to(:visible?) }
      end

      describe '#null' do
        subject { instance.null }

        it { subject.must_be_instance_of(NilClass) }
        it { instance.must_respond_to(:add) }
        it { instance.must_respond_to(:bottom_item) }
        it { instance.must_respond_to(:clear) }
        it { instance.must_respond_to(:colour) }
        it { instance.must_respond_to(:current_item) }
        it { instance.must_respond_to(:deselect_item) }
        it { instance.must_respond_to(:hide) }
        it { instance.must_respond_to(:item) }
        it { instance.must_respond_to(:items) }
        it { instance.must_respond_to(:next_item) }
        it { instance.must_respond_to(:parent) }
        it { instance.must_respond_to(:prev_item) }
        it { instance.must_respond_to(:render) }
        it { instance.must_respond_to(:select_item) }
        it { instance.must_respond_to(:selected_item) }
        it { instance.must_respond_to(:show) }
        it { instance.must_respond_to(:style) }
        it { instance.must_respond_to(:toggle) }
        it { instance.must_respond_to(:top_item) }
        it { instance.must_respond_to(:view) }
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

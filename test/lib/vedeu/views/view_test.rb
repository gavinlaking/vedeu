require 'test_helper'

module Vedeu

  module Views

    describe ViewCollection do

      let(:described) { Vedeu::Views::ViewCollection }
      let(:instance)  { described.new }

      it { described.superclass.must_equal(Vedeu::Repositories::Collection) }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
      end

    end # ViewCollection

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
      let(:_name)          { 'Vedeu::Views::View' }
      let(:parent)         {}
      let(:style)          {}
      let(:_value)         {}
      let(:zindex)         {}

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@client').must_equal(client) }
        it { instance.instance_variable_get('@colour').must_equal(colour) }
        it { instance.instance_variable_get('@cursor_visible').must_equal(cursor_visible) }
        it { instance.instance_variable_get('@name').must_equal(_name) }
        it { instance.instance_variable_get('@parent').must_equal(parent) }
        it { instance.instance_variable_get('@style').must_equal(style) }
        it { instance.instance_variable_get('@value').must_equal(_value) }
        it { instance.instance_variable_get('@zindex').must_equal(zindex) }
      end

      describe 'accessors' do
        it do
          instance.must_respond_to(:client)
          instance.must_respond_to(:client=)
          instance.must_respond_to(:cursor_visible)
          instance.must_respond_to(:cursor_visible=)
          instance.must_respond_to(:name)
          instance.must_respond_to(:name=)
          instance.must_respond_to(:parent)
          instance.must_respond_to(:parent=)
          instance.must_respond_to(:zindex)
          instance.must_respond_to(:zindex=)
        end
      end

      describe '#add' do
        let(:child) {}

        subject { instance.add(child) }

        # @todo Add more tests.
        # it { skip }
      end

      describe '#attributes' do
        subject { instance.attributes }

        it { subject.must_be_instance_of(Hash) }
      end

      describe '#deputy' do
        subject { instance.deputy }

        it 'returns the DSL instance' do
          subject.must_be_instance_of(Vedeu::DSL::View)
        end
      end

      describe '#store_immediate' do
        before { Vedeu.stubs(:trigger) }

        subject { instance.store_immediate }

        it { subject.must_be_instance_of(described) }

        it do
          Vedeu.expects(:trigger).with(:_refresh_view_, _name)
          subject
        end
      end

      describe '#store_deferred' do
        subject { instance.store_deferred }

        it { subject.must_be_instance_of(described) }

        context 'when the name is not defined' do
          let(:_name) {}

          it { proc { subject }.must_raise(Vedeu::Error::InvalidSyntax) }
        end
      end

      describe '#value' do
        subject { instance.value }

        it { instance.must_respond_to(:lines) }

        it { subject.must_be_instance_of(Vedeu::Views::Lines) }

        context 'when the value is not set' do
          # it { subject.must_equal('') }
        end

        context 'when the value is set' do
          let(:_value) { Vedeu::Views::Line.new }

          # it { subject.must_equal('') }
        end

        # @todo Add more tests.
        # it { skip }
      end

      describe '#value=' do
        let(:_value) { Vedeu::Views::Line.new }

        subject { instance.value=(_value) }

        it { instance.must_respond_to(:lines=) }

        context 'when the value is nil' do
          let(:_value) {}

          it { instance.value.must_be_instance_of(Vedeu::Views::Lines) }
        end

        context 'when the value is not nil' do
          let(:_value) { Vedeu::Views::Line.new }

          it { subject.must_be_instance_of(Vedeu::Views::Line) }
          it { instance.value.must_be_instance_of(Vedeu::Views::Lines) }
        end
      end

      describe '#value?' do
        subject { instance.value? }

        it { instance.must_respond_to(:lines?) }

        context 'when the view has no lines' do
          it { subject.must_equal(false) }
        end

        context 'when the view has lines' do
          before { instance.add(Vedeu::Views::Line.new) }

          it { subject.must_equal(true) }
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

    end # View

  end # Views

end # Vedeu

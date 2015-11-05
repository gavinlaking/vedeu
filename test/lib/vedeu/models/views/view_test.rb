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
          name: _name,
        }
      }
      let(:_name)      { 'Vedeu::Views::View' }

      describe 'accessors' do
        it {
          instance.must_respond_to(:attributes)
          instance.must_respond_to(:client)
          instance.must_respond_to(:client=)
          instance.must_respond_to(:cursor_visible)
          instance.must_respond_to(:cursor_visible=)
          instance.must_respond_to(:name)
          instance.must_respond_to(:name=)
          instance.must_respond_to(:parent)
          instance.must_respond_to(:parent=)
          instance.must_respond_to(:lines=)
          instance.must_respond_to(:zindex)
          instance.must_respond_to(:zindex=)
        }
      end

      describe '#add' do
        let(:child) {}

        subject { instance.add(child) }

        # @todo Add more tests.
        # it { skip }
      end

      describe '#deputy' do
        subject { instance.deputy }

        it 'returns the DSL instance' do
          subject.must_be_instance_of(Vedeu::DSL::View)
        end
      end

      describe '#value' do
        subject { instance.value }

        # @todo Add more tests.
        # it { skip }
      end

      describe '#store_immediate' do
        before { Vedeu.stubs(:trigger) }

        subject { instance.store_immediate }

        it { subject.must_be_instance_of(described) }

        it {
          Vedeu.expects(:trigger).with(:_refresh_view_, _name)
          subject
        }
      end

      describe '#store_deferred' do
        subject { instance.store_deferred }

        it { subject.must_be_instance_of(described) }

        context 'when the name is not defined' do
          let(:_name) {}

          it { proc { subject }.must_raise(Vedeu::Error::InvalidSyntax) }
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

# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Interfaces

    describe DSL do

      let(:described) { Vedeu::Interfaces::DSL }
      let(:instance)  { described.new(model, client) }
      let(:model)     {
        Vedeu::Interfaces::Interface.new(name: _name)
      }
      let(:_name)  { :vedeu_interfaces_dsl }
      let(:client) {}

      describe '.interface' do
        subject {
          described.interface(_name) do
            # ...
          end
        }

        context 'when the name is not given' do
          let(:_name) {}

          it { proc { subject }.must_raise(Vedeu::Error::MissingRequired) }
        end

        context 'when the name is given' do
          context 'when the block is not given' do
            subject { described.interface('fluorine') }

            it { proc { subject }.must_raise(Vedeu::Error::RequiresBlock) }
          end

          context 'when the block is given' do
            it { subject.must_be_instance_of(Vedeu::Interfaces::Interface) }
          end
        end
      end

      describe '#delay' do
        subject { instance.delay(0.25) }

        it do
          subject
          model.delay.must_equal(0.25)
        end
      end

      describe '#editable' do
        let(:_value) {}

        subject { instance.editable(_value) }

        context 'when the value is nil' do
          it { subject.must_equal(false) }
        end

        context 'when the value is false' do
          let(:_value) { false }

          it { subject.must_equal(false) }
        end

        context 'when the value is true' do
          let(:_value) { true }

          it { subject.must_equal(true) }
        end
      end

      describe '#editable!' do
        subject { instance.editable! }

        it { subject.must_equal(true) }
      end

      describe '#focus!' do
        subject { instance.focus! }

        context 'when the interface does not yet have a name' do
          let(:_name) {}

          it { assert_nil(subject) }
        end

        context 'when the interface has a name' do
          before { Vedeu::Models::Focus.reset }

          it { subject.must_equal([_name]) }
        end
      end

      describe '#group' do
        let(:_value) { 'elements' }

        before { Vedeu.groups.reset }

        subject { instance.group(_value) }

        it { subject.must_be_instance_of(Vedeu::Groups::Group) }

        context 'when the value is empty or nil' do
          let(:_value) { '' }

          it { subject.must_equal(false) }
        end

        context 'when the named group exists' do
          let(:members) { Set[_name, 'lanthanum'] }

          before do
            Vedeu::Groups::Group.new(name:    'elements',
                                     members: ['lanthanum']).store
          end

          it do
            subject
            Vedeu.groups.find('elements').members.must_equal(members)
          end
        end

        context 'when the named group does not exist' do
          it do
            subject
            Vedeu.groups.find('elements').members.must_equal(Set[_name])
          end
        end
      end

      describe '#keymap' do
        subject {
          instance.keys do
            # ...
          end
        }

        it { subject.must_be_instance_of(Vedeu::Input::Keymap) }
      end

      describe '#keys' do
        it { instance.must_respond_to(:keys) }
      end

      describe '#show!' do
        subject {
          Vedeu.interface 'xenon' do
            show!
          end
        }

        it { subject.visible.must_equal(true) }
      end

      describe '#hide!' do
        subject {
          Vedeu.interface 'xenon' do
            hide!
          end
        }

        it { subject.visible.must_equal(false) }
      end

      describe '#use' do
        before do
          Vedeu.interface 'some_interface' do
            delay 0.75
          end
          Vedeu.interface 'other_interface' do
            delay use('some_interface').delay
          end
        end
        after { Vedeu.interfaces.reset }

        subject { instance.use('other_interface').delay }

        it 'allows the use of another models attributes' do
          subject
          Vedeu.interfaces.by_name('other_interface').delay.must_equal(0.75)
        end
      end

      describe '#visible' do
        it { instance.visible(false).must_equal(false) }
        it { instance.visible(true).must_equal(true) }
        it { instance.visible(nil).must_equal(false) }
        it { instance.visible(:show).must_equal(true) }
      end

      describe '#zindex' do
        let(:_value) { 1 }

        subject { instance.zindex(_value) }

        it { subject.must_equal(1) }
      end

      describe '#z' do
        it { instance.must_respond_to(:z) }
      end

    end # DSL

  end # Interfaces

end # Vedeu

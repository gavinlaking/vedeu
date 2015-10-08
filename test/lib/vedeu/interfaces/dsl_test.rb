require 'test_helper'

module Vedeu

  module Interfaces

    describe DSL do

      let(:described) { Vedeu::Interfaces::DSL }
      let(:instance)  { described.new(model, client) }
      let(:model)     {
        Vedeu::Interfaces::Interface.new(name: _name)
      }
      let(:_name)  { 'actinium' }
      let(:client) {}

      describe '.interface' do
        after { Vedeu.interfaces.reset }

        subject {
          described.interface('fluorine') do
            # ...
          end
        }

        it { subject.must_be_instance_of(Vedeu::Interfaces::Interface) }

        context 'when the block is not given' do
          subject { described.interface('fluorine') }

          it { proc { subject }.must_raise(Vedeu::Error::RequiresBlock) }
        end

        context 'when the name is not given' do
          subject {
            described.interface('') do
              # ...
            end
          }

          it { proc { subject }.must_raise(Vedeu::Error::MissingRequired) }
        end
      end

      describe '#border' do
        after { Vedeu.borders.reset }

        context 'when the block is not given' do
          subject { instance.border }

          it { proc { subject }.must_raise(Vedeu::Error::RequiresBlock) }
        end

        context 'when the block is given' do
          subject { instance.border { } }

          it { subject.must_be_instance_of(Vedeu::Borders::Border) }

          context 'when the name is not given' do
            it 'uses the interface name for storing the border' do
              subject.name.must_equal('actinium')
            end
          end

          context 'when the name is given' do
            subject { instance.border('magnesium') { } }

            it 'uses the name for storing the border' do
              subject.name.must_equal('magnesium')
            end
          end
        end
      end

      describe '#border!' do
        after { Vedeu.borders.reset }

        subject { instance.border! }

        it { subject.must_be_instance_of(Vedeu::Borders::Border) }
      end

      describe '#cursor' do
        let(:_value) {}

        before { Vedeu.cursors.reset }

        subject { instance.cursor(_value) }

        it {
          subject
          Vedeu.cursors.find('actinium').visible?.must_equal(false)
        }

        context 'when the value is false' do
          let(:_value) { false }

          it {
            subject
            Vedeu.cursors.find('actinium').visible?.must_equal(false)
          }
        end

        context 'when the value is nil' do
          let(:_value) {}

          it {
            subject
            Vedeu.cursors.find('actinium').visible?.must_equal(false)
          }
        end

        context 'when the value is :show' do
          let(:_value) { :show }

          it {
            subject
            Vedeu.cursors.find('actinium').visible?.must_equal(true)
          }
        end

        context 'when the value is true' do
          let(:_value) { true }

          it {
            subject
            Vedeu.cursors.find('actinium').visible?.must_equal(true)
          }
        end

        context 'when the value is :yes' do
          let(:_value) { :yes }

          it {
            subject
            Vedeu.cursors.find('actinium').visible?.must_equal(true)
          }
        end
      end

      describe '#cursor!' do
        subject { instance.cursor! }

        it {
          subject
          Vedeu.cursors.find('actinium').visible?.must_equal(true)
        }
      end

      describe '#delay' do
        subject { instance.delay(0.25) }

        it {
          subject
          model.delay.must_equal(0.25)
        }
      end

      describe '#focus!' do
        subject { instance.focus! }

        context 'when the interface does not yet have a name' do
          let(:_name) {}

          it { subject.must_equal(nil) }
        end

        context 'when the interface has a name' do
          before { Vedeu::Models::Focus.reset }

          it { subject.must_equal(['actinium']) }
        end
      end

      describe '#geometry' do
        context 'when the required block is not provided' do
          subject { instance.geometry }

          it { proc { subject }.must_raise(Vedeu::Error::RequiresBlock) }
        end

        context 'when the block is given' do
          subject { instance.geometry { } }

          it { subject.must_be_instance_of(Vedeu::Geometry::Geometry) }

          context 'when the name is not given' do
            it 'uses the interface name for storing the geometry' do
              subject.name.must_equal('actinium')
            end
          end

          context 'when the name is given' do
            subject { instance.geometry('magnesium') { } }

            it 'uses the name for storing the geometry' do
              subject.name.must_equal('magnesium')
            end
          end
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
          let(:members) { Set['actinium', 'lanthanum'] }

          before do
            Vedeu::Groups::Group.new(name:    'elements',
                                     members: ['lanthanum']).store
          end

          it {
            subject
            Vedeu.groups.find('elements').members.must_equal(members)
          }
        end

        context 'when the named group does not exist' do
          it {
            subject
            Vedeu.groups.find('elements').members.must_equal(Set['actinium'])
          }
        end
      end

      describe '#keymap' do
        subject {
          instance.keys do
            # ...
          end
        }

        it { subject.must_be_instance_of(Vedeu::Input::Keymap) }
        it { instance.must_respond_to(:keys) }
      end

      describe '#name' do
        subject { instance.name('nickel') }

        it {
          subject
          model.name.must_equal('nickel')
        }
      end

      describe '#no_cursor!' do
        subject { instance.no_cursor! }

        it {
          subject
          Vedeu.cursors.find('actinium').visible?.must_equal(false)
        }
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
        it { instance.must_respond_to(:z_index) }
        it { instance.must_respond_to(:z) }
      end

    end # DSL

  end # Interfaces

end # Vedeu

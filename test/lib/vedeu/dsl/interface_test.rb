require 'test_helper'

module Vedeu

  module DSL

    describe Interface do

      let(:described) { Vedeu::DSL::Interface }
      let(:instance)  { described.new(model) }
      let(:model)     {
        Vedeu.interface 'actinium' do
          # ...
        end
      }
      let(:client) {}

      before { Vedeu.interfaces.reset }

      describe 'alias methods' do
        it { instance.must_respond_to(:keys) }
        it { instance.must_respond_to(:line) }
      end

      describe '#initialize' do
        it { instance.must_be_instance_of(Vedeu::DSL::Interface) }
        it { instance.instance_variable_get('@model').must_equal(model) }
        it { instance.instance_variable_get('@client').must_equal(client) }
      end

      describe '#border' do
        subject {
          instance.border do
            # ...
          end
        }

        context 'when the block is not given' do
          subject { instance.border }

          it { proc { subject }.must_raise(InvalidSyntax) }
        end

        context 'when the block is given' do
          subject { instance.border { } }

          it { subject.must_be_instance_of(Vedeu::Border) }

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
        subject { instance.border! }

        it { subject.must_be_instance_of(Vedeu::Border) }
      end

      describe '#cursor' do
        let(:value) {}

        before { Vedeu.cursors.reset }

        subject { instance.cursor(value) }

        it {
          subject
          Vedeu.cursors.find('actinium').visible?.must_equal(false)
        }

        context 'when the value is false' do
          let(:value) { false }

          it {
            subject
            Vedeu.cursors.find('actinium').visible?.must_equal(false)
          }
        end

        context 'when the value is nil' do
          let(:value) {}

          it {
            subject
            Vedeu.cursors.find('actinium').visible?.must_equal(false)
          }
        end

        context 'when the value is :show' do
          let(:value) { :show }

          it {
            subject
            Vedeu.cursors.find('actinium').visible?.must_equal(true)
          }
        end

        context 'when the value is true' do
          let(:value) { true }

          it {
            subject
            Vedeu.cursors.find('actinium').visible?.must_equal(true)
          }
        end

        context 'when the value is :yes' do
          let(:value) { :yes }

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
        it 'sets the delay attribute' do
          Vedeu.interface 'cobalt' do
            delay 0.25
          end

          Vedeu.use('cobalt').delay.must_equal(0.25)
        end
      end

      describe '#focus!' do
        context 'when a single call is made' do
          before do
            Vedeu::Focus.reset
            Vedeu.interface('curium') { focus! }
          end

          it 'sets the interface as current' do
            Vedeu.focus.must_equal('curium')
          end
        end

        context 'when no calls are made' do
          before do
            Vedeu::Focus.reset
            Vedeu.interface('curium')     {}
            Vedeu.interface('dysprosium') {}
          end

          it 'the first interface defined will be current' do
            Vedeu.focus.must_equal('curium')
          end
        end
      end

      describe '#geometry' do
        subject {
          instance.geometry do
            # ...
          end
        }

        context 'when the required block is not provided' do
          subject { instance.geometry }

          it { proc { subject }.must_raise(InvalidSyntax) }
        end

        context 'when the block is given' do
          subject { instance.geometry { } }

          it { subject.must_be_instance_of(Vedeu::Geometry) }

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
        let(:value) { 'elements' }

        before { Vedeu.groups.reset }

        subject { instance.group(value) }

        it { subject.must_be_instance_of(Vedeu::Group) }

        context 'when the value is empty or nil' do
          let(:value) { '' }

          it { subject.must_equal(false) }
        end

        context 'when the named group exists' do
          before do
            Vedeu::Group.new(name: 'elements', members: ['lanthanum']).store
          end

          it {
            subject
            Vedeu.groups.find('elements').members.must_equal(Set['actinium', 'lanthanum'])
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

        it { subject.must_be_instance_of(Vedeu::Keymap) }
      end

      describe '#lines' do
        subject {
          instance.lines do
            # ...
          end
        }

        it { subject.must_be_instance_of(Vedeu::Lines) }

        context 'when the required block is not provided' do
          subject { instance.lines }

          it { proc { subject }.must_raise(InvalidSyntax) }
        end
      end

      describe '#name' do
        it 'sets the name attribute' do
          Vedeu.interface do
            name 'nickel'
          end

          Vedeu.use('nickel').name.must_equal('nickel')
        end
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

      describe '#visible' do
        it { instance.visible(false).must_equal(false) }
        it { instance.visible(true).must_equal(true) }
        it { instance.visible(nil).must_equal(false) }
        it { instance.visible(:show).must_equal(true) }
      end

    end # Interface

  end # DSL

end # Vedeu

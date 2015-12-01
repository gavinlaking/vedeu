require 'test_helper'

module Vedeu

  module Events

    describe Aliases do

      let(:described) { Vedeu::Events::Aliases }

      before { described.reset! }

      describe '.add' do
        let(:alias_name) { :alias_test }
        let(:event_name) { :event_test }

        subject { described.add(alias_name, event_name) }

        it { described.must_respond_to(:bind_alias) }

        context 'when the alias is already registered' do
          before { described.add(:alias_test, :event_test) }

          it { subject.must_equal([:event_test, :event_test]) }
        end

        context 'when the alias is not already registered' do
          it { subject.must_equal([:event_test]) }
        end
      end

      describe '.empty?' do
        subject { described.empty? }

        context 'when no aliases are registered' do
          it { subject.must_equal(true) }
        end

        context 'when aliases are registered' do
          before { described.add(:alias_test, :event_test) }

          it { subject.must_equal(false) }
        end
      end

      describe '.find' do
        # @todo Add more tests
        # it { skip }
      end

      describe '.registered?' do
        let(:alias_name) { :alias_test }

        subject { described.registered?(alias_name) }

        context 'when the alias is registered' do
          before { described.add(:alias_test, :event_test) }

          it { subject.must_equal(true) }
        end

        context 'when the alias is not registered' do
          it { subject.must_equal(false) }
        end
      end

      describe '.remove' do
        let(:alias_name) { :alias_test }

        subject { described.remove(alias_name) }

        it { described.must_respond_to(:unbind_alias) }

        context 'when no aliases are registered' do
          it { subject.must_equal(false) }
        end

        context 'when the alias is not registered' do
          before { described.add(:other_alias_test, :event_test) }

          it { subject.must_equal(false) }
        end

        context 'when the alias is registered' do
          before { described.add(:alias_test, :event_test) }

          it { subject.must_equal({}) }
        end
      end

      describe '.reset!' do
        subject { described.reset! }

        it { described.must_respond_to(:reset) }

        it { subject.must_equal({}) }
      end

      describe '.storage' do
        subject { described.storage }

        it { subject.must_equal({}) }
      end

      describe '.trigger' do
        let(:alias_name) { :some_alias }
        let(:args)       {}

        subject { described.trigger(alias_name, *args) }

        context 'when the alias name is registered' do
          before do
            Vedeu.stubs(:log)
            Vedeu::Events::Trigger.stubs(:trigger)

            described.add(:some_alias, :some_event)
            described.add(:some_alias, :other_event)
          end

          it do
            Vedeu::Events::Trigger.expects(:trigger).with(:some_event, nil)
            Vedeu::Events::Trigger.expects(:trigger).with(:other_event, nil)
            subject
          end
        end

        context 'when the alias name is not registered' do
          let(:alias_name) {}

          it { subject.must_equal([]) }
        end
      end

    end # Aliases

  end # Events

end # Vedeu

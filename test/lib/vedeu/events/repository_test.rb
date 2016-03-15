# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Events

    describe Repository do

      let(:described) { Vedeu::Events::Repository }

      describe '.reset!' do
        subject { described.reset! }

        it { described.must_respond_to(:reset) }

        it do
          described.expects(:new).with(Vedeu::Events::Events)
          subject
        end
      end

    end # Repository

  end # Events

end # Vedeu

# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Events

    describe Events do

      let(:described) { Vedeu::Events::Events }
      let(:instance)  { described.new }

      it { described.superclass.must_equal(Vedeu::Repositories::Collection) }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
      end

    end # Events

  end # Events

end # Vedeu

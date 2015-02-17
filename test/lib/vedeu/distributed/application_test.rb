require 'test_helper'

module Vedeu

  module Distributed

    describe Application do

      let(:described) { Vedeu::Distributed::Application }
      let(:instance)  { described.new() }

      describe '#initialize' do
        subject { instance }

        it { subject.must_be_instance_of(Vedeu::Distributed::Application) }
      end

    end # Application

  end # Distributed

end # Vedeu

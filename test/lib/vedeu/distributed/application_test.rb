require 'test_helper'

module Vedeu

  module Distributed

    describe Application do

      let(:described)     { Vedeu::Distributed::Application }
      let(:instance)      { described.new(configuration) }
      let(:configuration) {}

      describe '#initialize' do
        subject { instance }

        it { subject.must_be_instance_of(Vedeu::Distributed::Application) }
        it { subject.instance_variable_get('@configuration').must_equal(configuration) }
      end

    end # Application

  end # Distributed

end # Vedeu

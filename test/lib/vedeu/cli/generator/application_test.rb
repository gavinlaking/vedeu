require 'test_helper'

module Vedeu

  module Generator

    describe Application do

      let(:described) { Vedeu::Generator::Application }
      let(:instance)  { described.new(_name) }
      let(:_name)     { 'my_first_app' }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@name').must_equal(_name) }
      end

      describe '.generate' do
        # before {
        #   FileUtils.stubs(:cp_r)
        #   FileUtils.stubs(:mkdir)
        # }

        subject { instance.generate(_name) }

        # @todo Add more tests.
      end

      describe '#generate' do
        it { instance.must_respond_to(:generate) }
      end

    end # Application

  end # Generator

end # Vedeu

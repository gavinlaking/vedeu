require 'test_helper'

module Vedeu

  module Generator

    describe Application do

      let(:described) { Vedeu::Generator::Application }
      let(:instance)  { described.new(_name) }
      let(:_name)     { 'my_first_app' }

      before do
        FileUtils.stubs(:cp_r)
        FileUtils.stubs(:mkdir)
      end

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@name').must_equal(_name) }
      end

      describe '.generate' do
        it { described.must_respond_to(:generate) }
      end

      describe '#generate' do
        subject { instance.generate }

        # @todo Add more tests.
      end

    end # Application

  end # Generator

end # Vedeu

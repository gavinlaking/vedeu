require 'test_helper'

module Vedeu

  module Generator

    class HelpersTestClass

      include Vedeu::Generator::Helpers

      def initialize(name)
        @name = name
      end

    end # HelpersTestClass

    describe Helpers do

      let(:described) { Vedeu::Generator::Helpers }
      let(:instance)  { Vedeu::Generator::HelpersTestClass.new(_name) }
      let(:_name)     { 'my_first_app' }

      describe '#make_file' do
        let(:source)      {}
        let(:destination) {}

        subject { instance.make_file(source, destination) }
      end

      describe '#name' do
        let(:_name) { 'My_First_APP' }

        subject { instance.name }

        it { subject.must_be_instance_of(String) }

        it { subject.must_equal('my_first_app') }
      end

      describe '#name_as_class' do
        subject { instance.name_as_class }

        it { subject.must_be_instance_of(String) }

        it { subject.must_equal('MyFirstApp') }
      end

      describe '#parse_file' do
        let(:source) {}

        subject { instance.parse_file(source) }
      end

      describe '#source' do
        subject { instance.source }

        it { subject.must_be_instance_of(String) }

        it { subject.must_match('vedeu/generator/templates/application/.') }
      end

    end # Helpers

  end # Generator

end # Vedeu

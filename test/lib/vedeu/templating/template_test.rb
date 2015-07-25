require 'test_helper'

module Vedeu

  module Templating

    describe Template do

      let(:described) { Vedeu::Templating::Template }
      let(:instance)  { described.new(object, path) }
      let(:object)    {}
      let(:path)      {}

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@object').must_equal(object) }
        it { instance.instance_variable_get('@path').must_equal('') }
      end

      describe '.parse' do
        subject { described.parse(object, path) }

        context 'when the path is empty' do
          let(:path) { '' }

          it { proc { subject }.must_raise(MissingRequired) }
        end

        context 'when the path is does not exist' do
          let(:path) { '/tmp/vedeu_does_not_exist' }

          it { proc { subject }.must_raise(MissingRequired) }
        end

        context 'when the path exists' do
          let(:path) { 'test/support/templates/plain.erb' }
          let(:expected) { "This is a test.\n" }

          it { subject.must_equal(expected) }
        end
      end

    end # Templating

  end # Template

end # Vedeu

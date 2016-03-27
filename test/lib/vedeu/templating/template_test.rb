# frozen_string_literal: true

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

          it { proc { subject }.must_raise(Vedeu::Error::MissingRequired) }
        end

        context 'when the path is does not exist' do
          let(:path) { Dir.tmpdir + '/vedeu_does_not_exist' }

          before { File.stubs(:exist?).returns(false) }

          it { proc { subject }.must_raise(Vedeu::Error::MissingRequired) }
        end

        context 'when the path exists' do
          let(:path) { Dir.tmpdir + '/vedeu_exists' }
          let(:expected) { "This is a test.\n" }

          before do
            File.stubs(:exist?).returns(true)
            File.stubs(:read).returns(expected)
          end

          it { subject.must_equal(expected) }
        end
      end

      describe '#parse' do
        it { instance.must_respond_to(:parse) }
      end

    end # Templating

  end # Template

end # Vedeu

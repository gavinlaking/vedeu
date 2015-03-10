require 'test_helper'

module Vedeu

  describe Template do

    let(:described) { Vedeu::Template }
    let(:instance)  { described.new(object, path) }
    let(:object)    {}
    let(:path)      {}

    describe '#initialize' do
      it { instance.must_be_instance_of(Vedeu::Template) }
      it { instance.instance_variable_get('@object').must_equal(object) }
      it { instance.instance_variable_get('@path').must_equal('') }
    end

    describe '.parse' do
      subject { described.parse(object, path) }

      before { File.stubs(:read).returns('') }

      context 'when the path is empty' do
        it { proc { subject }.must_raise(MissingRequired) }
      end

      context 'when the path is does not exist' do
        let(:path) { '/tmp/vedeu_does_not_exist' }

        it { proc { subject }.must_raise(MissingRequired) }
      end

      context 'when the path exists' do
        let(:path) { '/tmp/vedeu_does_exist' }

        before { File.stubs(:exist?).returns(true) }

        it { subject.must_equal('') }
      end
    end

  end # Template

end # Vedeu

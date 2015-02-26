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
      it { instance.instance_variable_get('@path').must_equal(path) }
    end

    describe '.parse' do
      subject { described.parse(object, path) }
    end

  end # Template

end # Vedeu

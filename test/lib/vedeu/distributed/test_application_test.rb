require 'test_helper'

module Vedeu

  describe TestApplication do

    let(:described)  { Vedeu::TestApplication }
    let(:instance)   { described.new(attributes) }
    let(:attributes) { {} }

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
    end

    describe 'accessors' do
      it {
        instance.must_respond_to(:borders)
        instance.must_respond_to(:borders=)
        instance.must_respond_to(:configuration)
        instance.must_respond_to(:configuration=)
        instance.must_respond_to(:events)
        instance.must_respond_to(:events=)
        instance.must_respond_to(:geometries)
        instance.must_respond_to(:geometries=)
        instance.must_respond_to(:interfaces)
        instance.must_respond_to(:interfaces=)
        instance.must_respond_to(:keymaps)
        instance.must_respond_to(:keymaps=)
        instance.must_respond_to(:menus)
        instance.must_respond_to(:menus=)
        instance.must_respond_to(:views)
        instance.must_respond_to(:views=)
      }
    end

    describe '.build' do
      subject { described.build(attributes) { } }

      it { subject.must_be_instance_of(String) }
    end

    describe '#lib_dir' do
      subject { instance.lib_dir }

      it { subject.must_be_instance_of(String) }
    end

  end # TestApplication

end # Vedeu

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
      it { instance.must_respond_to(:borders) }
      it { instance.must_respond_to(:borders=) }
      it { instance.must_respond_to(:configuration) }
      it { instance.must_respond_to(:configuration=) }
      it { instance.must_respond_to(:events) }
      it { instance.must_respond_to(:events=) }
      it { instance.must_respond_to(:geometries) }
      it { instance.must_respond_to(:geometries=) }
      it { instance.must_respond_to(:interfaces) }
      it { instance.must_respond_to(:interfaces=) }
      it { instance.must_respond_to(:keymaps) }
      it { instance.must_respond_to(:keymaps=) }
      it { instance.must_respond_to(:menus) }
      it { instance.must_respond_to(:menus=) }
      it { instance.must_respond_to(:views) }
      it { instance.must_respond_to(:views=) }
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

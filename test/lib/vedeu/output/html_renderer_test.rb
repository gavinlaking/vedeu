require 'test_helper'

module Vedeu

  describe HTMLRenderer do

    let(:described) { Vedeu::HTMLRenderer }
    let(:instance)  { described.new(output) }
    let(:output)    {}

    describe '#initialize' do
      it { instance.must_be_instance_of(Vedeu::HTMLRenderer) }
      it { instance.instance_variable_get('@output').must_equal(output) }
    end

    describe '#render' do
      subject { instance.render }

      it { subject.must_be_instance_of(String) }
    end

    describe '.to_file' do
      before { File.stubs(:open) }

      subject { described.to_file(output, path) }

      context 'when a path is given' do
        let(:path) { '/tmp/test_vedeu_html_renderer.html' }

        #it { subject.must_equal('') }
      end

      context 'when a path is not given' do
        let(:path) {}


      end
    end

  end # HTMLRenderer

end # Vedeu

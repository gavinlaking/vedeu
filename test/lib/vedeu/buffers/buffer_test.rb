require 'test_helper'

module Vedeu

  module Buffers

    describe Buffer do

      let(:described)  { Vedeu::Buffers::Buffer }
      let(:instance)   { described.new(attributes) }
      let(:_name)      { 'krypton' }
      let(:back)       {}
      let(:front)      {}
      let(:previous)   {}
      let(:interface)  {}
      let(:attributes) {
        {
          name:     _name,
          back:     back,
          front:    front,
          previous: previous,
        }
      }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@name').must_equal(_name) }
        it { instance.instance_variable_get('@back').must_equal(back) }
        it { instance.instance_variable_get('@front').must_equal(front) }
        it { instance.instance_variable_get('@previous').must_equal(previous) }
        it do
          instance.instance_variable_get('@repository').must_equal(Vedeu.buffers)
        end
      end

      describe 'accessors' do
        it {
          instance.must_respond_to(:back)
          instance.must_respond_to(:back=)
          instance.must_respond_to(:front)
          instance.must_respond_to(:front=)
          instance.must_respond_to(:previous)
          instance.must_respond_to(:previous=)
          instance.must_respond_to(:name)
        }
      end

      describe '#add' do
        let(:content) {
          Vedeu::Views::View.new(value: [Vedeu::Views::Line.new])
        }

        subject { instance.add(content) }

        it { subject.must_equal(true) }
      end

      describe '#back?' do
        subject { instance.back? }

        context 'with content' do
          let(:back) {
            Vedeu::Views::View.new(value: [Vedeu::Views::Line.new])
          }

          it { subject.must_equal(true) }
        end

        context 'without content' do
          it { subject.must_equal(false) }
        end
      end

      describe '#front?' do
        subject { instance.front? }

        context 'with content' do
          let(:front) {
            Vedeu::Views::View.new(value: [Vedeu::Views::Line.new])
          }

          it { subject.must_equal(true) }
        end

        context 'without content' do
          it { subject.must_equal(false) }
        end
      end

      describe '#previous?' do
        subject { instance.previous? }

        context 'with content' do
          let(:previous) {
            Vedeu::Views::View.new(value: [Vedeu::Views::Line.new])
          }

          it { subject.must_equal(true) }
        end

        context 'without content' do
          it { subject.must_equal(false) }
        end
      end

      describe '#render' do
        before {
          Vedeu.stubs(:log)
          Vedeu.stubs(:render_output)
        }

        subject { instance.render }

        context 'when there is new content on the back buffer' do
          let(:back) {
            Vedeu::Views::View.new(value: [Vedeu::Views::Line.new])
          }

          it {
            Vedeu::Output::Viewport.expects(:render)
            subject
          }
        end

        context 'when there is existing content on the front buffer' do
          let(:front) {
            Vedeu::Views::View.new(value: [Vedeu::Views::Line.new])
          }

          it {
            Vedeu::Output::Viewport.expects(:render)
            subject
          }
        end

        context 'when there is content on the previous buffer' do
          let(:previous) {
            Vedeu::Views::View.new(value: [Vedeu::Views::Line.new])
          }

          it {
            Vedeu::Output::Viewport.expects(:render)
            subject
          }
        end

        context 'when there is no content on any buffer' do
          it { subject.must_equal(nil) }
        end
      end

    end # Buffer

  end # Buffers

end # Vedeu

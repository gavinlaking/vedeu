# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Buffers

    describe Buffer do

      let(:described)  { Vedeu::Buffers::Buffer }
      let(:instance)   { described.new(attributes) }
      let(:attributes) {
        {
          back:     back,
          front:    front,
          name:     _name,
          previous: previous,
        }
      }
      let(:back)       {}
      let(:front)      {}
      let(:_name)      { :vedeu_buffers_buffer }
      let(:previous)   {}

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@name').must_equal(_name) }
        it { instance.instance_variable_get('@back').must_equal(back) }
        it { instance.instance_variable_get('@front').must_equal(front) }
        it { instance.instance_variable_get('@previous').must_equal(previous) }
        it do
          instance.instance_variable_get('@repository')
            .must_equal(Vedeu.buffers)
        end
      end

      describe '#back' do
        it { instance.must_respond_to(:back) }
      end

      describe '#back=' do
        it { instance.must_respond_to(:back=) }
      end

      describe '#front' do
        it { instance.must_respond_to(:front) }
      end

      describe '#front=' do
        it { instance.must_respond_to(:front=) }
      end

      describe '#previous' do
        it { instance.must_respond_to(:previous) }
      end

      describe '#previous=' do
        it { instance.must_respond_to(:previous=) }
      end

      describe '#name' do
        it { instance.must_respond_to(:name) }
      end

      describe '#add' do
        let(:refresh) { false }
        let(:content) {
          Vedeu::Views::View.new(name:  :vedeu_buffers_buffer,
                                 value: [Vedeu::Views::Line.new])
        }

        subject { instance.add(content, refresh) }

        it { subject.must_equal(true) }

        context 'when refresh is true' do
          let(:refresh) { true }

          before { Vedeu.stubs(:trigger) }

          it do
            Vedeu.expects(:trigger).with(:_refresh_view_, :vedeu_buffers_buffer)
            subject
          end
        end
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

      describe '#cursor_visible?' do
        let(:buffer) {
          Vedeu::Views::View.new(value: [Vedeu::Views::Line.new],
                                 cursor_visible: cursor_visible)
        }
        let(:cursor_visible) { false }

        subject { instance.cursor_visible? }

        context 'when there is a front buffer' do
          let(:front) { buffer }

          context 'when the cursor is visible' do
            let(:cursor_visible) { true }

            it { subject.must_equal(true) }
          end

          context 'when the cursor is not visible' do
            it { subject.must_equal(false) }
          end
        end

        context 'when there is a previous buffer' do
          let(:front)    {}
          let(:previous) { buffer }

          context 'when the cursor is visible' do
            let(:cursor_visible) { true }

            it { subject.must_equal(true) }
          end

          context 'when the cursor is not visible' do
            it { subject.must_equal(false) }
          end
        end

        context 'when neither a front or previous buffer exists (yet)' do
          let(:front)     {}
          let(:previous)  {}

          context 'when an interface exists' do
            let(:interface) {
              Vedeu::Interfaces::Interface.new(name: _name, cursor_visible: cursor_visible)
            }
            let(:cursor_visible) { false }

            before do
              Vedeu.interfaces.stubs(:by_name).with(_name).returns(interface)
            end

            context 'when the interface cursor_visible is false' do
              it { subject.must_equal(false) }
            end

            context 'when the interface cursor_visible is true' do
              let(:cursor_visible) { true }

              it { subject.must_equal(true) }
            end
          end

          context 'when an interface does not exist' do
            it 'uses the Interface::Null cursor_visible (always false)' do
              subject.must_equal(false)
            end
          end
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

          it do
            Vedeu::Output::Viewport.expects(:render)
            subject
          end
        end

        context 'when there is existing content on the front buffer' do
          let(:front) {
            Vedeu::Views::View.new(value: [Vedeu::Views::Line.new])
          }

          it do
            Vedeu::Output::Viewport.expects(:render)
            subject
          end
        end

        context 'when there is content on the previous buffer' do
          let(:previous) {
            Vedeu::Views::View.new(value: [Vedeu::Views::Line.new])
          }

          it do
            Vedeu::Output::Viewport.expects(:render)
            subject
          end
        end

        context 'when there is no content on any buffer' do
          it { assert_nil(subject) }
        end
      end

      describe '#size' do
        subject { instance.size }

        context 'when there is new content on the back buffer' do
          let(:back) {
            Vedeu::Views::View.new(value: [Vedeu::Views::Line.new])
          }

          it { subject.must_equal(1) }
        end

        context 'when there is existing content on the front buffer' do
          let(:front) {
            Vedeu::Views::View.new(value: [Vedeu::Views::Line.new])
          }

          it { subject.must_equal(1) }
        end

        context 'when there is content on the previous buffer' do
          let(:previous) {
            Vedeu::Views::View.new(value: [Vedeu::Views::Line.new])
          }

          it { subject.must_equal(1) }
        end

        context 'when there is no content on any buffer' do
          it { subject.must_equal(0) }
        end
      end

    end # Buffer

  end # Buffers

end # Vedeu

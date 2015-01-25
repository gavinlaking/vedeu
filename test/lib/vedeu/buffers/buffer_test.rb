require 'test_helper'

module Vedeu

  describe Buffer do

    let(:described)   { Vedeu::Buffer }
    let(:instance)    { described.new(buffer_name, back, front, previous) }
    let(:buffer_name) { 'krypton' }
    let(:back)        {}
    let(:front)       {}
    let(:previous)    {}

    before { Vedeu.stubs(:trigger) }

    describe '#initialize' do
      subject { instance }

      it { return_type_for(subject, described) }
      it { subject.instance_variable_get('@name').must_equal(buffer_name) }
      it { subject.instance_variable_get('@back').must_equal(back) }
      it { subject.instance_variable_get('@front').must_equal(front) }
      it { subject.instance_variable_get('@previous').must_equal(previous) }
      it { subject.instance_variable_get('@repository').must_equal(Vedeu.buffers) }
    end

    describe '#add' do
      let(:back) {
        Vedeu::Interface.build do
          lines do
            line 'old_back'
          end
        end
      }
      let(:content) {
        Vedeu::Interface.build do
          lines do
            line 'new_back'
          end
        end
      }

      subject { instance.add(content) }

      it { subject.must_equal(true) }

      it 'replaces the back buffer with the content' do
        instance.back.must_equal(back)

        subject

        instance.back.must_equal(content)
      end
    end

    describe '#content' do
      subject { instance.content }

      it { return_type_for(subject, Array) }

      context 'when there is content on the back buffer' do
        let(:back) {
        Vedeu::Interface.build do
          lines do
            line 'old_back'
          end
        end
        }
        let(:buffer) { :back }

        it { subject.must_equal([back]) }
      end

      context 'when there is no content on the back buffer' do
        let(:buffer) { :back }

        it { subject.must_equal([]) }
      end

      context 'when there is no content on the back buffer' do
        let(:back) {}
        let(:buffer) { :back }

        it { subject.must_equal([]) }
      end

      context 'when there is content on the front buffer' do
        let(:buffer) { :front }
        let(:front) {
          Vedeu::Interface.build do
            lines do
              line 'front'
            end
          end
        }

        it { subject.must_equal([front]) }
      end

      context 'when there is no content on the front buffer' do
        let(:buffer) { :front }

        it { subject.must_equal([]) }
      end

      context 'when there is no content on the front buffer' do
        let(:buffer) { :front }
        let(:front)  {}

        it { subject.must_equal([]) }
      end

      context 'when there is content on the previous buffer' do
        let(:buffer) { :previous }
        let(:previous) {
          Vedeu::Interface.build do
            lines do
              line 'old_back'
            end
          end
        }

        it { subject.must_equal([previous]) }
      end

      context 'when there is no content on the previous buffer' do
        let(:buffer) { :previous }

        it { subject.must_equal([]) }
      end

      context 'when there is no content on the previous buffer' do
        let(:buffer)   { :previous }
        let(:previous) {}

        it { subject.must_equal([]) }
      end
    end

    describe '#swap' do
      subject { instance.swap }

      context 'when there is new content on the back buffer' do
        let(:back) {
          Vedeu::Interface.build do
            lines do
              line 'back'
            end
          end
        }
        let(:front) {
          Vedeu::Interface.build do
            lines do
              line 'front'
            end
          end
        }
        let(:previous) {
          Vedeu::Interface.build do
            lines do
              line 'previous'
            end
          end
        }

        context 'when the buffer was updated successfully' do
          it { subject.must_equal(true) }
        end

        it 'replaces the previous buffer with the front buffer' do
          subject
          instance.previous.must_equal(front)
        end

        it 'replaces the front buffer with the back buffer' do
          subject
          instance.front.must_equal(back)
        end

        it 'replaces the back buffer with an empty buffer' do
          subject
          instance.back.must_equal(nil)
        end
      end

      context 'when there is no new content on the back buffer' do
        it { subject.must_equal(false) }
      end
    end

  end # Buffer

end # Vedeu

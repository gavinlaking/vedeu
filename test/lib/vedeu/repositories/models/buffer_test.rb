require 'test_helper'

module Vedeu

  describe Buffer do

    let(:attributes) {
      {
        name:     '',
        back:     back,
        front:    front,
        previous: previous,
      }
    }
    let(:back)     { {} }
    let(:front)    { {} }
    let(:previous) { {} }

    describe '#initialize' do
      it 'returns an instance of Buffer' do
        Buffer.new(attributes).must_be_instance_of(Buffer)
      end
    end

    describe '#back' do
      subject { Buffer.new(attributes).back }

      it { subject.must_be_instance_of(Hash) }
    end

    describe '#front' do
      subject { Buffer.new(attributes).front }

      it { subject.must_be_instance_of(Hash) }

      context 'alias method: #current' do
        subject { Buffer.new(attributes).current }

        it { subject.must_be_instance_of(Hash) }
      end
    end

    describe '#name' do
      subject { Buffer.new(attributes).name }

      it { subject.must_be_instance_of(String) }
    end

    describe '#previous' do
      subject { Buffer.new(attributes).previous }

      it { subject.must_be_instance_of(Hash) }
    end

    describe '#content' do
      subject { Buffer.new(attributes).content }

      context 'when there is content on the back buffer' do
        let(:back) { { lines: [{ streams: [{ text: 'back' }] }] } }
        let(:buffer) { :back }

        it { subject.must_equal([{}, back]) }
      end

      context 'when there is no content on the back buffer' do
        let(:buffer) { :back }

        it { subject.must_equal([{}]) }
      end

      context 'when there is no content on the back buffer' do
        let(:back) { { lines: [] } }
        let(:buffer) { :back }

        it { subject.must_equal([{}]) }
      end

      context 'when there is content on the front buffer' do
        let(:buffer) { :front }
        let(:front) { { lines: [{ streams: [{ text: 'front' }] }] } }

        it { subject.must_equal([front]) }
      end

      context 'when there is no content on the front buffer' do
        let(:buffer) { :front }

        it { subject.must_equal([{}]) }
      end

      context 'when there is no content on the front buffer' do
        let(:buffer) { :front }

        let(:front) { { lines: [] } }

        it { subject.must_equal([{}]) }
      end

      context 'when there is content on the previous buffer' do
        let(:buffer) { :previous }
        let(:previous) { { lines: [{ streams: [{ text: 'previous' }] }] } }

        it { subject.must_equal([previous]) }
      end

      context 'when there is no content on the previous buffer' do
        let(:buffer) { :previous }

        it { subject.must_equal([{}]) }
      end

      context 'when there is no content on the previous buffer' do
        let(:buffer) { :previous }
        let(:previous) { { lines: [] } }

        it { subject.must_equal([{}]) }
      end
    end

    describe '#add' do
      let(:attributes) {
        {
          back: { lines: [{ streams: [{ text: 'old_back' }] }] }
        }
      }
      let(:buffer)  { Buffer.new(attributes) }
      let(:content) { { lines: [{ streams: [{ text: 'new_back' }] }] } }

      subject { buffer.add(content) }

      it { subject.must_equal(true) }

      it 'replaces the back buffer with the content' do
        buffer.back.must_equal({ lines: [{ streams: [{ text: 'old_back' }] }] })

        subject

        buffer.back.must_equal({ lines: [{ streams: [{ text: 'new_back' }] }] })
      end
    end

    describe '#swap' do
      let(:buffer) { Buffer.new(attributes) }

      subject { buffer.swap }

      context 'when there is new content on the back buffer' do
        let(:back)     { { lines: [{ streams: [{ text: 'back' }] }] } }
        let(:front)    { { lines: [{ streams: [{ text: 'front' }] }] } }
        let(:previous) { { lines: [{ streams: [{ text: 'previous' }] }] } }

        context 'when the buffer was updated successfully' do
          it { subject.must_equal(true) }
        end

        it 'replaces the previous buffer with the front buffer' do
          subject
          buffer.previous.must_equal(front)
        end

        it 'replaces the front buffer with the back buffer' do
          subject
          buffer.front.must_equal(back)
        end

        it 'replaces the back buffer with an empty buffer' do
          subject
          buffer.back.must_equal({})
        end
      end

      context 'when there is no new content on the back buffer' do
        it { subject.must_equal(false) }
      end
    end

  end # Buffer

end # Vedeu

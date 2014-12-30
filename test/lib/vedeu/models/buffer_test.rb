require 'test_helper'

module Vedeu

  describe Buffer do

    let(:described) { Buffer.new(attributes) }
    let(:attributes) {
      {
        name:     'krypton',
        back:     back,
        front:    front,
        previous: previous,
      }
    }
    let(:back)     { {} }
    let(:front)    { {} }
    let(:previous) { {} }

    describe '#initialize' do
      it { return_type_for(described, Buffer) }
      it { assigns(described, '@name', 'krypton') }
      it { assigns(described, '@back', {}) }
      it { assigns(described, '@front', {}) }
      it { assigns(described, '@previous', {}) }
    end

    describe '#back' do
      it { return_type_for(described.back, Hash) }
    end

    describe '#front' do
      it { return_type_for(described.front, Hash) }

      context 'alias method: #current' do
        it { return_type_for(described.current, Hash) }
      end
    end

    describe '#name' do
      it { return_type_for(described.name, String) }
    end

    describe '#previous' do
      it { return_type_for(described.previous, Hash) }
    end

    describe '#content' do
      it { return_type_for(described.content, Array) }

      subject { Buffer.new(attributes).content }

      context 'when there is content on the back buffer' do
        let(:back) { { lines: [{ streams: [{ text: 'back' }] }] } }
        let(:buffer) { :back }

        it { skip; subject.must_equal([{}, back]) }
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
          back: { lines: [{ streams: [{ text: 'old_back' }] }] },
          name: 'krypton'
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

    # describe '#swap' do
    #   let(:buffer) { Buffer.new(attributes) }

    #   subject { buffer.swap }

    #   context 'when there is new content on the back buffer' do
    #     let(:back)     { { lines: [{ streams: [{ text: 'back' }] }] } }
    #     let(:front)    { { lines: [{ streams: [{ text: 'front' }] }] } }
    #     let(:previous) { { lines: [{ streams: [{ text: 'previous' }] }] } }

    #     context 'when the buffer was updated successfully' do
    #       it { subject.must_equal(true) }
    #     end

    #     it 'replaces the previous buffer with the front buffer' do
    #       subject
    #       buffer.previous.must_equal(front)
    #     end

    #     it 'replaces the front buffer with the back buffer' do
    #       subject
    #       buffer.front.must_equal(back)
    #     end

    #     it 'replaces the back buffer with an empty buffer' do
    #       subject
    #       buffer.back.must_equal({})
    #     end
    #   end

    #   context 'when there is no new content on the back buffer' do
    #     it { subject.must_equal(false) }
    #   end
    # end

  end # Buffer

end # Vedeu

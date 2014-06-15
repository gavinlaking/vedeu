require_relative '../../../test_helper'

module Vedeu
  describe Compositor do
    let(:described_class)    { Compositor }
    let(:described_instance) { described_class.new(output, interface) }
    let(:subject)            { described_instance }
    let(:output)             { [[]] }
    let(:stream)             { [] }
    let(:interface)          { 'dummy' }

    before do
      Interface.create({ name: 'dummy' })
      Interface.create({ name: 'test_interface' })
      Renderer.stubs(:write).returns(stream)
    end

    after do
      InterfaceRepository.reset
    end

    it { subject.must_be_instance_of(Compositor) }
    it { subject.instance_variable_get("@output").must_equal([[]]) }
    it { subject.instance_variable_get("@interface").must_equal("dummy") }

    describe '.arrange' do
      let(:subject) { described_class.arrange(output, interface) }

      context 'when empty' do
        let(:output) { [] }

        it { subject.must_be_instance_of(NilClass) }
      end

      context 'when an array (single interface)' do
        let(:output) { [[]] }

        it { subject.must_be_instance_of(Array) }
      end

      context 'when a hash (multiple interfaces)' do
        let(:output) { { 'test_interface' => [] } }

        it { subject.must_be_instance_of(Array) }
      end

      context 'when unstyled' do
        context 'and a single line' do
          let(:output) { [['Some text...']] }
          let(:stream) { 'Some text...' }

          it { subject.must_equal(stream) }
        end

        context 'and multi-line' do
          let(:output) {
            [
              ['Some text...'],
              ['Some more text...']
            ]
          }
          let(:stream) { "Some text...\nSome more text..." }

          it { subject.must_equal(stream) }
        end
      end

      context 'when styled' do
        context 'with colour pair' do
          context 'and a single line' do
            let(:output) {
              [
                [{ colour: [:red, :white] }, 'Some text...']
              ]
            }
            let(:stream) { "\e[38;5;31m\e[48;5;47mSome text..." }

            it { subject.must_equal(stream) }
          end

          context 'and multi-line' do
            let(:output) {
              [
                [{ colour: [:red, :white] },   'Some text...'],
                [{ colour: [:blue, :yellow] }, 'Some more text...']
              ]
            }
            let(:stream) {
              "\e[38;5;31m\e[48;5;47mSome text...\n" \
              "\e[38;5;34m\e[48;5;43mSome more text..."
            }

            it { subject.must_equal(stream) }
          end
        end

        context 'with a style' do
          context 'and a single line' do
            let(:output) {
              [
                [{ style: :bold }, 'Some text...']
              ]
            }
            let(:stream) {
              "\e[1mSome text..."
            }

            it { subject.must_equal(stream) }
          end

          context 'and multi-line' do
            let(:output) {
              [
                [{ style: :inverse },   'Some text...'],
                [{ style: :underline }, 'Some more text...']
              ]
            }
            let(:stream) {
              "\e[7mSome text...\n" \
              "\e[4mSome more text..."
            }

            it { subject.must_equal(stream) }
          end
        end

        context 'with an unknown style' do
          let(:output) {
            [
              [{ style: :unknown }, 'Some text...']
            ]
          }
          let(:stream) {
            "Some text..."
          }

          it 'renders in the default style' do
            subject.must_equal(stream)
          end
        end
      end
    end
  end
end

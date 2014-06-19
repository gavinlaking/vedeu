require_relative '../../../test_helper'

module Vedeu
  describe Compositor do
    let(:described_class)    { Compositor }
    let(:described_instance) { described_class.new(attributes) }
    let(:subject)            { described_instance }
    let(:attributes)         { { interface: 'dummy', stream: stream } }
    let(:stream)             { [[]] }
    let(:composition)        {}

    before do
      Interface.create({ name: 'dummy', width: 15, height: 2 })
    end

    after do
      InterfaceRepository.reset
    end

    it 'returns a Compositor instance' do
      subject.must_be_instance_of(Compositor)
    end

    it 'sets an instance variable' do
      subject.instance_variable_get('@attributes').must_equal(attributes)
    end

    it 'sets an instance variable' do
      subject.instance_variable_get('@interface').must_equal(attributes[:interface])
    end

    it 'sets an instance variable' do
      subject.instance_variable_get('@stream').must_equal(attributes[:stream])
    end

    describe '#arrange' do
      let(:subject)    { described_class.new(attributes).arrange }

      context 'when empty' do
        let(:stream)      { [[]] }
        let(:composition) {
          [
            [
              "\e[38;2;39m\e[48;2;49m",
              "\e[1;1H               \e[1;1H",
              "\e[2;1H               \e[2;1H",
              "\e[38;2;39m\e[48;2;49m",
              "\e[?25h"
            ]
          ]
        }

        it 'returns the initial state of the interface' do
          subject.must_equal(composition)
        end

        it 'returns an Array' do
          subject.must_be_instance_of(Array)
        end
      end

      context 'when unstyled' do
        context 'and a single line' do
          let(:stream)      { [['Some text...']] }
          let(:composition) {
            [
              [
                "\e[38;2;39m\e[48;2;49m",
                "\e[1;1H               \e[1;1HSome text...",
                "\e[2;1H               \e[2;1H",
                "\e[38;2;39m\e[48;2;49m",
                "\e[?25h"
              ]
            ]
          }

          it 'returns the enqueued composition' do
            subject.must_equal(composition)
          end
        end

        context 'and multi-line' do
          let(:stream) {
            [
              ['Some text...'],
              ['Some more text...']
            ]
          }
          let(:composition) {
            [
              [
                "\e[38;2;39m\e[48;2;49m",
                "\e[1;1H               \e[1;1HSome text...",
                "\e[2;1H               \e[2;1HSome more tex...\e[0m",
                "\e[38;2;39m\e[48;2;49m",
                "\e[?25h"
              ]
            ]
          }

          it 'returns the enqueued composition' do
            subject.must_equal(composition)
          end
        end
      end

      context 'when styled' do
        context 'with colour pair' do
          context 'and a single line' do
            let(:stream) {
              [
                [{ colour: [:red, :white] }, 'Some text...']
              ]
            }
            let(:composition) {
              [
                [
                  "\e[38;2;39m\e[48;2;49m",
                  "\e[1;1H               \e[1;1H\e[38;2;31m\e[48;2;47mSome text...",
                  "\e[2;1H               \e[2;1H",
                  "\e[38;2;39m\e[48;2;49m",
                  "\e[?25h"
                ]
              ]
            }

            it 'returns the enqueued composition' do
              subject.must_equal(composition)
            end
          end

          context 'and multi-line' do
            let(:stream) {
              [
                [{ colour: [:red, :white] },   'Some text...'],
                [{ colour: [:blue, :yellow] }, 'Some more text...']
              ]
            }
            let(:composition) {
              [
                [
                  "\e[38;2;39m\e[48;2;49m",
                  "\e[1;1H               \e[1;1H\e[38;2;31m\e[48;2;47mSome text...",
                  "\e[2;1H               \e[2;1H\e[38;2;34m\e[48;2;43mSome more tex...\e[0m",
                  "\e[38;2;39m\e[48;2;49m",
                  "\e[?25h"
                ]
              ]
            }

            it 'returns the enqueued composition' do
              subject.must_equal(composition)
            end
          end
        end

        context 'with a style' do
          context 'and a single line' do
            let(:stream)      { [[{ style: :bold }, 'Some text...']] }
            let(:composition) {
              [
                [
                  "\e[38;2;39m\e[48;2;49m",
                  "\e[1;1H               \e[1;1H\e[1mSome text...",
                  "\e[2;1H               \e[2;1H",
                  "\e[38;2;39m\e[48;2;49m",
                  "\e[?25h"
                ]
              ]
            }

            it 'returns the enqueued composition' do
              subject.must_equal(composition)
            end
          end

          context 'and multi-line' do
            let(:stream) {
                [
                  [{ style: :inverse },   'Some text...'],
                  [{ style: :underline }, 'Some more text...']
                ]
            }
            let(:composition) {
              [
                [
                  "\e[38;2;39m\e[48;2;49m",
                  "\e[1;1H               \e[1;1H\e[7mSome text...",
                  "\e[2;1H               \e[2;1H\e[4mSome more tex...\e[0m",
                  "\e[38;2;39m\e[48;2;49m",
                  "\e[?25h"
                ]
              ]
            }

            it 'returns the enqueued composition' do
              subject.must_equal(composition)
            end
          end
        end

        context 'with an unknown style' do
          let(:stream)      { [[{ style: :unknown }, 'Some text...']] }
          let(:composition) {
            [
              [
                "\e[38;2;39m\e[48;2;49m",
                "\e[1;1H               \e[1;1HSome text...",
                "\e[2;1H               \e[2;1H",
                "\e[38;2;39m\e[48;2;49m",
                "\e[?25h"
              ]
            ]
          }

          it 'returns the enqueued composition' do
            subject.must_equal(composition)
          end
        end
      end
    end
  end
end

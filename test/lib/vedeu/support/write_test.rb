require 'test_helper'

module Vedeu

  describe Write do

    let(:described) { Vedeu::Write }
    let(:instance)  { described.new(console, data) }
    let(:console)   { Vedeu::Console.new(height, width) }
    let(:data)      {}
    let(:height)    { 4 }
    let(:width)     { 30 }

    describe '#initialize' do
      subject { instance }

      it { skip; subject.must_be_instance_of(described) }
      it { skip; subject.instance_variable_get('@console').must_equal(console) }
      it { skip; subject.instance_variable_get('@data').must_equal(data) }
    end

    describe '.to' do
      subject { described.to(console, data) }

      it { skip; subject.must_be_instance_of(String) }

      context 'when no data is given' do
        it { skip; subject.must_equal('') }
      end

      context 'when data is given' do
        context 'and the data is an Array' do
          context 'when the data is an Array of Arrays' do
            let(:data) {
              [
                [
                  Vedeu::Char.new('g'),
                  Vedeu::Char.new('o'),
                  Vedeu::Char.new('l'),
                  Vedeu::Char.new('d'),
                ],
                [
                  Vedeu::Char.new('i'),
                  Vedeu::Char.new('r'),
                  Vedeu::Char.new('o'),
                  Vedeu::Char.new('n'),
                ],
              ]
            }

            it { skip; subject.must_equal('') }
          end

          context 'when the data is an Array of Strings' do
            let(:data) {
              [
                'The first two elements are:',
                '',
                'Hydrogen',
                'Helium'
              ]
            }

            it { skip; subject.must_equal('') }
          end

          context 'when the data is an Array of unsupported types' do
            let(:data) { [{}, {}] }

            it { skip; subject.must_equal('') }
          end
        end

        context 'and the data is a String' do
          context 'when the data contains line breaks' do
            let(:data) { "The first two elements are:\n\nHydrogen\nHelium\n" }

            context 'when there are more lines than can be displayed' do
              let(:height) { 3 }

              it { skip; subject.must_equal('') }
            end

            context 'when there are not more lines than can be displayed' do
              it { skip; subject.must_equal('') }
            end
          end

          context 'when the data does not contain line breaks' do
            let(:data) { 'This is just a line of text.' }

            context 'when there are more columns than can be displayed' do
              let(:width) { 20 }
            end

            context 'when there are not more columns than can be displayed' do
              it { skip; subject.must_equal('') }
            end
          end
        end

        context 'and the data is an unsupported type' do
          let(:data) { {} }

          it { skip; subject.must_equal('') }
        end
      end
    end

  end # Write

end # Vedeu

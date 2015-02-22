require 'test_helper'

module Vedeu

  describe Write do

    let(:described) { Vedeu::Write }
    let(:instance)  { described.new(console, data) }
    let(:console)   { Vedeu::Console.new(height, width) }
    let(:data)      {}
    let(:height)    { 3 }
    let(:width)     { 40 }

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
      it { instance.instance_variable_get('@console').must_equal(console) }
      it { instance.instance_variable_get('@data').must_equal(data) }
    end

    describe '.to' do
      subject { described.to(console, data) }

      it { subject.must_be_instance_of(Array) }

      context 'when the data is larger than the visible area' do
        context 'when the data is a String' do
          let(:data) {
            "Zinc, in commerce also spelter, is a chemical\n" \
            "element with symbol Zn and atomic number 30.\n"  \
            "It is the first element of group 12 of the\n"    \
            "periodic table."
          }

          it { subject.must_equal(
            [
              "Zinc, in commerce also spelter, is a che",
              "element with symbol Zn and atomic number",
              "It is the first element of group 12 of t"
            ])
          }
        end

        context 'when the data is an Array' do
          # Zinc...
          # -.Zn.12
          # Spelter
          # ..Metal
          let(:data) {
            [
              [
                Vedeu::Char.new({ value: 'Z' }),
                Vedeu::Char.new({ value: 'i' }),
                Vedeu::Char.new({ value: 'n' }),
                Vedeu::Char.new({ value: 'c' }),
                Vedeu::Char.new({ value: '.' }),
                Vedeu::Char.new({ value: '.' }),
                Vedeu::Char.new({ value: '.' })
              ],[
                Vedeu::Char.new({ value: '-' }),
                Vedeu::Char.new({ value: '.' }),
                Vedeu::Char.new({ value: 'Z' }),
                Vedeu::Char.new({ value: 'n' }),
                Vedeu::Char.new({ value: '.' }),
                Vedeu::Char.new({ value: '1' }),
                Vedeu::Char.new({ value: '2' })
              ],[
                Vedeu::Char.new({ value: 'S' }),
                Vedeu::Char.new({ value: 'p' }),
                Vedeu::Char.new({ value: 'e' }),
                Vedeu::Char.new({ value: 'l' }),
                Vedeu::Char.new({ value: 't' }),
                Vedeu::Char.new({ value: 'e' }),
                Vedeu::Char.new({ value: 'r' })
              ],[
                Vedeu::Char.new({ value: '.' }),
                Vedeu::Char.new({ value: '.' }),
                Vedeu::Char.new({ value: 'M' }),
                Vedeu::Char.new({ value: 'e' }),
                Vedeu::Char.new({ value: 't' }),
                Vedeu::Char.new({ value: 'a' }),
                Vedeu::Char.new({ value: 'l' })
              ],
            ]
          }
          let(:height) { 3 }
          let(:width) { 5 }
          let(:expected) {
            data[0, height].map { |line| line[0, width] }
          }

          it { subject.must_equal(expected) }
        end
      end

      context 'when the data is not larger than the visible area' do
        context 'when the data is a String' do
          let(:data) {
            "Gallium is a chemical element with\n" \
            "symbol Ga and atomic number 31.\n"
          }

          it { subject.must_equal(
            [
              "Gallium is a chemical element with",
              "symbol Ga and atomic number 31."
            ])
          }
        end

        context 'when the data is an Array' do
          # Gallium
          # -.Ga.31
          let(:data) {
            [
              [
                Vedeu::Char.new({ value: 'G' }),
                Vedeu::Char.new({ value: 'a' }),
                Vedeu::Char.new({ value: 'l' }),
                Vedeu::Char.new({ value: 'l' }),
                Vedeu::Char.new({ value: 'i' }),
                Vedeu::Char.new({ value: 'u' }),
                Vedeu::Char.new({ value: 'm' })
              ], [
                Vedeu::Char.new({ value: '-' }),
                Vedeu::Char.new({ value: '.' }),
                Vedeu::Char.new({ value: 'G' }),
                Vedeu::Char.new({ value: 'a' }),
                Vedeu::Char.new({ value: '.' }),
                Vedeu::Char.new({ value: '3' }),
                Vedeu::Char.new({ value: '1' })
              ]
            ]
          }
          let(:height) { 3 }
          let(:width) { 10 }

          it { subject.must_equal(data) }
        end
      end

      context 'when there is no data' do
        let(:data) {}

        it { subject.must_equal([]) }
      end
    end

    describe '#print' do
      let(:string) {}

      subject { instance.print(string) }

      it { subject.must_be_instance_of(Array) }
    end

  end # Write

end # Vedeu

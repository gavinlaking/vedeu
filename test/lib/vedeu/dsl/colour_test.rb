require 'test_helper'

module Vedeu

  module DSL

    describe Colour do

      describe '#background' do
        it 'sets the models colour to the desired value' do
          skip
        end

        context 'alias_method' do
          context ':bg' do
            it 'sets the models colour to the desired value' do
              skip
            end
          end

          context ':bgcolor' do
            it 'sets the models colour to the desired value' do
              skip
            end
          end
        end
      end

      describe '#colour' do
        context 'when the keys are valid' do
          context 'when the values is valid' do
            it 'sets the models colour to the desired values' do
              skip
            end
          end

          context 'when a value is invalid' do
            it 'discards the invalid key and value' do
              skip
            end
          end
        end

        context 'when aa key is invalid' do
          it 'discards the invalid key and value' do
            skip
          end
        end
      end

      describe '#foreground' do
        it 'sets the models colour to the desired value' do
          skip
        end

        context 'alias_method' do
          context ':fg' do
            it 'sets the models colour to the desired value' do
              skip
            end
          end

          context ':fgcolor' do
            it 'sets the models colour to the desired value' do
              skip
            end
          end
        end
      end

    end # Colour

  end # DSL

end # Vedeu

require 'test_helper'

describe 'DSL Stream tests' do

  # describe '#align' do
  #   it ':left' do
  #     Vedeu.view 'test' do
  #       line do
  #         stream do
  #           align :left
  #         end
  #       end
  #     end.must_equal({})
  #   end

  #   it ':right' do
  #     Vedeu.view 'test' do
  #       line do
  #         stream do
  #           align :right
  #         end
  #       end
  #     end.must_equal({})
  #   end

  #   it ':centre' do
  #     Vedeu.view 'test' do
  #       line do
  #         stream do
  #           align :centre
  #         end
  #       end
  #     end.must_equal({})
  #   end

  #   it ':invalid' do
  #     proc { Vedeu.view 'test' do
  #              line do
  #                stream do
  #                  align :invalid
  #                end
  #              end
  #     end }.must_raise(Vedeu::InvalidSyntax)
  #   end

  #   it ':right overriding :centre' do
  #     Vedeu.view 'test' do
  #       line do
  #         stream do
  #           align :centre
  #           align :right
  #         end
  #       end
  #     end.must_equal({})
  #   end
  # end

  # describe '#centre' do
  #   it 'centre' do
  #     Vedeu.view 'test' do
  #       line do
  #         stream do
  #           align centre
  #         end
  #       end
  #     end.must_equal({})
  #   end
  # end

  # describe '#left' do
  #   it 'left' do
  #     Vedeu.view 'test' do
  #       line do
  #         stream do
  #           align left
  #         end
  #       end
  #     end.must_equal({})
  #   end
  # end

  # describe '#right' do
  #   it 'right' do
  #     Vedeu.view 'test' do
  #       line do
  #         stream do
  #           align right
  #         end
  #       end
  #     end.must_equal({})
  #   end
  # end

  # describe '#text' do
  #   it 'text' do
  #     Vedeu.view 'test' do
  #       line do
  #         stream do
  #           text 'Some text...'
  #         end
  #       end
  #     end.must_equal({})
  #   end

  #   it 'invalid' do
  #     proc { Vedeu.view 'test' do
  #       line do
  #         stream do
  #           text
  #         end
  #       end
  #     end }.must_raise(ArgumentError)
  #   end
  # end

  # describe '#width' do
  #   it 'width' do
  #     Vedeu.view 'test' do
  #       line do
  #         stream do
  #           width 35
  #         end
  #       end
  #     end.must_equal({})
  #   end

  #   it 'invalid' do
  #     proc { Vedeu.view 'test' do
  #       line do
  #         stream do
  #           width
  #         end
  #       end
  #     end }.must_raise(ArgumentError)
  #   end
  # end

end

# view :name do
#   lines do
#     line 'view->lines->line', {}
#
#     line do
#       streams do
#         stream 'view->lines->line->streams->stream', {}
#         stream do
#           text 'view->lines->line->streams->stream->text', {}
#         end
#         text 'view->lines->line->streams->text', {}
#       end
#
#       stream 'view->lines->line->stream', {}
#
#       stream do
#         text 'view->lines->line->stream->text', {}
#       end
#
#       text 'view->lines->line->text', {}
#     end
#
#     streams do
#       stream 'view->lines->streams->stream', {}
#       stream do
#         text 'view->lines->streams->stream->text', {}
#       end
#       text 'view->lines->streams->text', {}
#     end
#
#     stream 'view->lines->stream', {}
#     stream do
#       text 'view->lines->stream->text', {}
#     end
#
#     text 'view->lines->text', {}
#   end
#
#   line 'view->line', {}
#
#   line do
#     streams do
#       stream 'view->line->streams->stream', {}
#       stream do
#         text 'view->line->streams->stream->text', {}
#       end
#       text 'view->line->streams->text', {}
#     end
#
#     stream 'view->line->stream->stream', {}
#     stream do
#       text 'view->line->stream->text', {}
#     end
#
#     text 'view->line->text', {}
#   end
#
#   streams do
#     stream 'view->streams->stream', {}
#     stream do
#       text 'view->streams->stream->text', {}
#     end
#     text 'view->streams->text', {}
#   end
#
#   stream 'view->stream', {}
#
#   stream do
#     text 'view->stream->text', {}
#   end
#
#   text 'view->text', {}
# end
#
# 'view->line'
# 'view->line->stream->stream'
# 'view->line->stream->text'
# 'view->line->streams->stream'
# 'view->line->streams->stream->text'
# 'view->line->streams->text'
# 'view->line->text'
# 'view->lines->line'
# 'view->lines->line->stream'
# 'view->lines->line->stream->text'
# 'view->lines->line->streams->stream'
# 'view->lines->line->streams->stream->text'
# 'view->lines->line->streams->text'
# 'view->lines->line->text'
# 'view->lines->stream'
# 'view->lines->stream->text'
# 'view->lines->streams->stream'
# 'view->lines->streams->stream->text'
# 'view->lines->streams->text'
# 'view->lines->text'
# 'view->stream'
# 'view->stream->text'
# 'view->streams->stream'
# 'view->streams->stream->text'
# 'view->streams->text'
# 'view->text'

## Views with Vedeu

There are two ways to construct views with Vedeu. You would like to draw the
view to the screen immediately (immediate render) or you want to save a view to
be drawn when you trigger a refresh event later (deferred view).

** LINK Both of these approaches require that you have defined an interface (or
'visible area') first. You can find out how to define an interface with Vedeu
here. The examples in 'Immediate Render' and 'Deferred View' use these interface
definitions: (Note: if you use these examples, ensure your terminal is at least
70 characters in width and 5 lines in height.)

```ruby
  Vedeu.interface 'main' do
    geometry do
      centred!
      height 4
      width  50
    end
  end

  Vedeu.interface 'title' do
    geometry do
      height 1
      width  50
      x      use('main').left
      y      use('main').north
    end
  end
```

Both of these approaches use a concept of Buffers in Vedeu. There are three
buffers for any defined interface. These are imaginatively called: 'back',
'front' and 'previous'.

The 'back' buffer is the content for an interface which will be shown next time
a refresh event is fired globally or for that interface. So, 'back' becomes
'front'.

The 'front' buffer is the content for an interface which is currently showing.
When a refresh event is fired, again, globally or for that interface
specifically, the content of this 'front' buffer is first copied to the
'previous' buffer, and then the current 'back' buffer overwrites this 'front'
buffer.

The 'previous' buffer contains what was shown on the 'front' before the current
'front'.

You can only write to either the 'front' (you want the content to be drawn
immediately) or the 'back' (you would like the content to be drawn on the next
refresh).

### Immediate Render

The immediate render DSL for Vedeu is accessed via `Vedeu.render` or
`Vedeu.renders`. When this approach is used, the content defined is written
directly to the 'front' buffer(s) for the interface(s) concerned. Take a glance at
the example below:

```ruby
  Vedeu.render do
    views do
      view 'title' do
        line do
          stream do
            left 'Title goes here', width: 35
          end
          stream do
            right Time.now.strftime('%H:%m'), width: 7
          end
        end
      end
      view 'main' do
        lines do
          line 'This is content for the main interface.'
          line ''
          line 'Pretty easy eh?'
        end
      end
    end
  end
```

### Deferred View

The deferred view DSL for Vedeu is accessed via `Vedeu.view` or `Vedeu.views`.
This approach writes the content defined to the 'back' buffer(s) for the
interface(s) concerned. It will become the front when your application triggers
the refresh event for the interface(s).

As you can see by comparing the examples above to these below, the immediate
render simply wraps what is already here in the deferred view. Again, more
specific information is available in the Rubydoc.

```ruby
  Vedeu.views do
    view 'title' do
      line do
        stream do
          left 'Title goes here', width: 35
        end
        stream do
          right Time.now.strftime('%H:%m'), width: 7
        end
      end
    end
    view 'main' do
      lines do
        line 'This is content for the main interface.'
        line ''
        line 'Pretty easy eh?'
      end
    end
  end
```

### Notes on Geometry

... TODO

### Notes on Refresh

... TODO

#### Authors Notes

The Rubydoc documentation has more specific information about the DSL methods
demonstrated above; it can be accessed here.

I've tried to write the DSL in a way which makes it read nice; believing that
this will make it easier to use. I hope this is the case for you.


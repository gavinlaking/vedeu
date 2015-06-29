## Vedeu Applications

Vedeu has basic tools to generate client application scaffolding, in a similar
way to Ruby on Rails. Although not nearly as advanced as the Rails equivalent,
hopefully these generators will get you off the ground.

### Application Structure

|
|- app_name/
|   |
    |- app/
    |   |- controllers
    |   |- helpers
    |   |- models
    |   |    |- keymaps
    |   |- views
    |        |- interfaces
    |        |- templates
    |
    |- bin
    |- config
    |- lib
    |- test
    |- vendor
    |

To create the application structure as shown above:

    vedeu new app_name

Let's talk about each directory and its purpose.

#### app/controllers

The controllers directory is the place to store the events and behaviour logic
of your application. It will manage the choosing of views and models based on
previous choices. Think of them as the orchestrators of your application.

In web applications, the controller typically handles the routed request and
interacts with the models and sets up the views. In Vedeu, it does much the
same, minus the requests.

#### app/helpers

Ruby on Rails has a concept of helpers which are not very object-oriented, but
allow you to share functionality/behaviour across multiple views. Vedeu uses
this concept as it will be familiar to many Rails developers and might be
helpful to beginners.

#### app/models

Much like `lib`, this directory is for your application logic code. Some people
prefer to use `app/models`, others like to use `lib`. Some even use both!

#### app/models/keymaps

This will contain the global keymap (which affects all of your application)
plus any specific interface keymaps which only affect a certain interface when
in focus.

#### app/views

This will contain classes which produce the views needed by Vedeu to make your
application come alive!

#### app/views/interfaces

This will contain the information Vedeu needs to draw the various interfaces
and views of your application.

#### app/views/templates

This will house the templates your application will use to display views. You
can populate templates with generic view information and supplement it with
variable data from your application.

#### bin

This will contain executable Ruby scripts (or Bash, or shell language of your
choice) which will launch your application or provide command-line behaviours.

#### config

This will contain any configuration your application needs to run, plus the
configuration for Vedeu. This configuration affects the way Vedeu works with
your application.

#### lib

This is for code your application may use to support code you have in
`app/models`.

#### test

This is for the tests you might write to help ensure your application executes
in the way you expect.

#### vendor

This is for third-party code which your application might want to ship with.
Usually you will include various Ruby gems to provide functionality, but you
might want to do something special.

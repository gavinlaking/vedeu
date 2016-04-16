# @title Building a simple application using Vedeu
# Building a simple application using Vedeu

In this small tutorial, I hope to guide you through the process of
building a simple application which uses the Vedeu framework.

We're going to build a Slack bot. This bot will simply relay the
messages sent to a specific channel to your terminal to be displayed.
In a future episode, I might extend this to be able to send messages
back too to demonstrate other aspects of Vedeu, but one step at a
time.

If you would like to create a single file application, please see this
tutorial: {file:docs/application/simple_application}[Simple
 Application].

If you would like to create a gem which uses Vedeu, please see this
tutorial: {file:docs/gem_application}[Gem Application].

If you would like to include Vedeu in an existing application, please
see this tutorial: {file:docs/existing_application}[Existing
 Application].

If you would like to create a standalone application, please continue
reading...

## 1) Getting started.

First, install the gem locally:

    gem install vedeu

This will provide a new command to help build your client application.
Similar to Ruby on Rails, although not nearly as advanced as the Rails
equivalent, hopefully the `vedeu` command generators will get you off
the ground:

    vedeu

Running the `vedeu` command with no arguments will give you a list of
the commands currently supported.

We can create a skeleton Vedeu client application using the following
command:

    vedeu new your_app_name

If `your_app_name` already exists, Vedeu will only write new files
that do not exist at the file path. The generated files are a skeleton
Vedeu client application. Let's take a look at these files
individually.

@todo Add more documentation.

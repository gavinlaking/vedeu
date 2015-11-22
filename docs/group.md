# @title Vedeu Groups
# Vedeu Groups

Vedeu allows you to create collections of interfaces, these are called
Groups.

- They have a name, which means you can control a collection of
  interfaces by this name.
- Interfaces which are part of a group are the members of that group.
  - It is generally wise not to have interfaces which are members of
    multiple groups.
- They can be visible or invisible, this affects all of the members of
  the group.

## API

### All groups

This repository contains all the registered groups for a client
application. They can be listed via:

    Vedeu.groups.all

### An individual group

You can access an individual group by name:

    Vedeu.groups.find(:name)

    # or...

    Vedeu.groups.by_name(:name)

### Hiding a group

You can hide a group, and all of its interfaces/views:

    Vedeu.trigger(:_hide_group_, :name)

    # or...

    Vedeu.hide_group(:name)

### Showing a group

You can show a group, and all of its interfaces/views:

    Vedeu.trigger(:_show_group_, :name)

    # or...

    Vedeu.show_group(:name)


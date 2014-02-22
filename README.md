# Eventualize [![Build Status](https://travis-ci.org/kevgo/eventualize.png?branch=master)](https://travis-ci.org/kevgo/eventualize)

Eventualize introduces a
convention-over-configuration mechanism for semi-automatically binding
properly named event handlers
to jQuery-compatible event sources
in your object-oriented JavaScript code.

All you have to do is
* name your event handlers appropriately: `on_[event source]_[event_name]`
* eventualize your class: `eventualize(this)`

This works everywhere where you handle events using JavaScript.
Here is an example for handling jQuery events in the browser:

```coffeescript
class ConfirmDialog

  constructor: ->
    @confirm_button = $('#confirm')
    @cancel_button = $('#cancel')

    # Wire up all event listeners that exist in this class.
    # This is equivalent to
    # - @confirm_button.on 'click', @on_confirm_button_click
    # - @cancel_button.on 'click', @on_cancel_button_click
    # - @cancel_button.on 'hover', @on_cancel_button_hover
    eventualize this


  @on_yes_button_click: ->
    console.log 'The yes button was clicked'

  @on_no_button_click: ->
    console.log 'The no button was clicked'

  @on_no_button_hover: ->
    console.log 'The no button was hovered'
```

Eventualize also works on the server, for example with Node.js:

```coffeescript
class Stream

  constructor: ->
    @socket = new Socket()

    # Wire up all event listeners in this class.
    # This is equivalent to
    # - @socket.on 'open', @on_socket_open
    # - @socket.on 'data', @on_socket_data
    # - @socket.on 'error', @on_socket_error
    # - @socket.on 'close', @on_socket_close
    eventualize this


  @on_socket_open = (err, handle) ->
    console.log 'The socket is open'

  @on_socket_data = (err, data) ->
    console.log 'Received new data'

  @on_socket_error = (err, message) ->
    console.log "Error: #{message}"

  @on_socket_close = (err) ->
    console.log 'Socket closed'
```


## Development

* tell us about an idea for a new feature: https://github.com/kevgo/eventualize/issues
* praise or feedback: https://github.com/kevgo
* set up the development environment on your machine: `npm install`
* run tests: `npm test`
* compile a new release: `grunt release`
* contribute some changes: unit-tested pull requests please!  :heart_eyes_cat:


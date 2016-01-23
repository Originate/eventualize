# Eventualize [![Build Status](https://travis-ci.org/kevgo/eventualize.svg?branch=master)](https://travis-ci.org/kevgo/eventualize)

Eventualize introduces a
convention-over-configuration mechanism for semi-automatically binding
properly named
[EventEmitter](https://nodejs.org/api/events.html)
or jQuery-compatible event sources
in your object-oriented JavaScript code.

All you have to do is
* make your event handlers methods of a class
* name your event handlers appropriately: `on[event source][event_name]`
* eventualize your class: `eventualize(this)`

This works everywhere where you handle events using JavaScript.
Here is an example for handling jQuery events in the browser:

```coffeescript
class ConfirmDialog

  constructor: ->
    @confirmButton = $('#confirm')
    @cancelButton = $('#cancel')

    # Wire up all event listeners that exist in this class.
    # This is equivalent to
    # - @confirmButton.on 'click', @onConfirmButtonClick
    # - @cancelButton.on 'click', @onCancelButtonClick
    # - @cancelButton.on 'hover', @onCancelButtonHover
    eventualize this


  @onConfirmButtonClick: ->
    console.log 'The confirm button was clicked'

  @onCancelButtonClick: ->
    console.log 'The cancel button was clicked'

  @onCancelButtonHover: ->
    console.log 'The cancel button was hovered'
```

Eventualize also works for [EventEmitters](https://nodejs.org/api/events.html) in Node.js:

```coffeescript
class Stream

  constructor: ->
    @socket = new Socket()

    # Wire up all event listeners in this class.
    # This is equivalent to
    # - @socket.on 'open', @onSocketOpen
    # - @socket.on 'data', @onSocketData
    # - @socket.on 'error', @onSocketError
    # - @socket.on 'close', @onSocketClose
    eventualize this


  @onSocketOpen = (err, handle) ->
    console.log 'The socket is open'

  @onSocketData = (err, data) ->
    console.log 'Received new data'

  @onSocketError = (err, message) ->
    console.log "Error: #{message}"

  @onSocketClose = (err) ->
    console.log 'Socket closed'
```


## Development

* tell us about an idea for a new feature: https://github.com/kevgo/eventualize/issues
* praise or feedback: https://github.com/kevgo
* set up the development environment on your machine: `npm install`
* run tests: `npm test`
* compile a new release: `grunt release`
* contribute some changes: unit-tested pull requests please!  :heart_eyes_cat:


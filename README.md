# Eventualize [![Circle CI](https://circleci.com/gh/Originate/eventualize.svg?style=shield)](https://circleci.com/gh/Originate/eventualize)

Eventualize provides convention-based automatic event binding
for [EventEmitters](https://nodejs.org/api/events.html)
or jQuery-compatible event sources
in your object-oriented JavaScript code.

```coffeescript
class ConfirmDialog

  constructor: ->
    @confirmButton = $('#confirm')
    @cancelButton = $('#cancel')

    # This call wires up all properly named event listeners in this class.
    # It is equivalent to running:
    # @confirmButton.on 'click', @onConfirmButtonClick
    # @cancelButton.on 'click', @onCancelButtonClick
    # @cancelButton.on 'hover', @onCancelButtonHover
    eventualize this

  @onConfirmButtonClick: -> ...
  @onCancelButtonClick: -> ...
  @onCancelButtonHover: -> ...
```

Eventualize also works for [EventEmitters](https://nodejs.org/api/events.html) in Node.js:

```coffeescript
class Stream

  constructor: ->
    @socket = new Socket()

    # This call is equivalent to
    # @socket.on 'open', @onSocketOpen
    # @socket.on 'data', @onSocketData
    # @socket.on 'error', @onSocketError
    # @socket.on 'close', @onSocketClose
    eventualize this


  @onSocketOpen = (err, handle) -> ...
  @onSocketData = (err, data) -> ...
  @onSocketError = (err, message) -> ...
  @onSocketClose = (err) -> ...
```


## Development

See the [developer guidelines](CONTRIBUTING.md)

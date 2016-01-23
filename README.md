# Eventualize

> convention-based automatic event binding
for [EventEmitters](https://nodejs.org/api/events.html)
in your object-oriented JavaScript code

[![Circle CI](https://circleci.com/gh/Originate/eventualize.svg?style=shield)](https://circleci.com/gh/Originate/eventualize) [![Dependency Status](https://david-dm.org/Originate/eventualize.svg)](https://david-dm.org/Originate/eventualize) [![devDependency Status](https://david-dm.org/Originate/eventualize/dev-status.svg)](https://david-dm.org/Originate/eventualize#info=devDependencies)

```coffeescript
class Stream

  constructor: ->
    @socket = new Socket()

    # This call wires up all properly named event listeners in this class.
    # It is equivalent to running:
    # @socket.on 'open', @onSocketOpen
    # @socket.on 'data', @onSocketData
    # @socket.on 'error', @onSocketError
    eventualize this


  @onSocketOpen = (err, handle) -> ...
  @onSocketData = (err, data) -> ...
  @onSocketError = (err, message) -> ...
```

This also works for jQuery event emitters in the browser:

```coffeescript
class ConfirmDialog

  constructor: ->
    @confirmButton = $('#confirm')
    @cancelButton = $('#cancel')

    # This call is equivalent to
    # @confirmButton.on 'click', @onConfirmButtonClick
    # @cancelButton.on 'click', @onCancelButtonClick
    # @cancelButton.on 'hover', @onCancelButtonHover
    eventualize this

  @onConfirmButtonClick: -> ...
  @onCancelButtonClick: -> ...
  @onCancelButtonHover: -> ...
```


## Development

See the [developer guidelines](CONTRIBUTING.md)

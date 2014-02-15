# Eventualize [![Build Status](https://travis-ci.org/kevgo/eventualize.png?branch=master)](https://travis-ci.org/kevgo/eventualize)

_Eventualizes your code until it experiences the ultimate eventualization_

Eventualize is a JavaScript microlibrary that introduces a
convention-over-configuration pattern so that jQuery-compatible events
are automatically bound to properly named event handlers
in your JavaScript code.

This means it makes the right "on" calls on your class members to subscribe
the matching event handlers for you automatically.
All you have to do is
* let your class inherit from Eventualize
* name your event handlers appropriately
* tell your class to eventualize itself

This works in the browser, for example for jQuery elements, or more complex
UI elements that fire jQuery events:

```coffeescript
class ConfirmDialog extends Eventualize

  constructor: ->

    # An example button class that fires "click" events.
    @yes_button = $('#yes')

    # Another example button class that fires "click" and "hover" events.
    @no_button = $('#no')

    # Wire up all event listeners in this class.
    #
    # This is equivalent to
    # - @yes_button.on 'click', @on_yes_button_click
    # - @no_button.on 'click', @on_no_button_click
    # - @no_button.on 'hover', @on_no_button_hover
    @eventualize()


  # Called when the yes_button is clicked.
  @on_yes_button_click: ->


  # Called when the no_button is clicked.
  @on_no_button_click: ->


  # Called when the no_button is hovered.
  @on_no_button_hover: ->
```

It also works on the server if you are running Node.js:

```coffeescript
class Mailer extends Eventualize

  constructor: ->

    # A JavaScript object that can fire 'ready' and 'error' events.
    @smtp_gateway = new SmtpGateway()

    # Wire up all event listeners in this class.
    #
    # This is equivalent to
    # - @smtp_gateway.on 'ready', @on_smtp_gateway_ready
    # - @smtp_gateway.on 'error', @on_smtp_gateway_error
    @eventualize()


  # Called when the SMTP gateway fires the 'ready' event.
  @on_smtp_gateway_ready = (err, handle) ->


  # Called when the SMTP gateway fires the 'error' event.
  @on_smtp_gateway_error = (err, message) ->
```


## Development

* make a feature request: open an issue on the Github page
* praise or feedback: https://github.com/kevgo
* set up dev environment: `npm install`
* run tests: `npm test`
* compile a new release: `grunt release`
* contribute some changes: unit-tested pull requests please!  :)


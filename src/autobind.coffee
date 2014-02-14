
# Provides autobinding to a class.
class Autobind

  # Automatically binds all events fired by properties of this class
  # to their corresponding "on_[property name]_[method name]" methods.
  autobind: ->
    [fields, callbacks] = @categorize_members()
    for field in fields
      for callback in callbacks
        if Autobind.is_callback_for callback, field
          @[field].on Autobind.callback_event_name(callback, field),
                      @[callback]

    # Prevent inefficient JavaScript.
    undefined


  # Returns all the fields and all callbacks of the current instance.
  #
  # Callbacks are methods that begin with 'on_'.
  categorize_members: ->
    fields = []
    callbacks = []
    for element of @
      switch typeof @[element]
        when 'object'
          fields.push element
        when 'function'
          callbacks.push element if Autobind.is_callback_method element
    [fields, callbacks]


  # Returns whether the method with the given name is a callback method.
  @is_callback_method: (method_name) ->
    @string_starts_with method_name, 'on_'


  # Returns whether the method with the given name
  # is a callback for the event with the given name.
  @is_callback_for: (method_name, event_name) ->
    @string_starts_with method_name, "on_#{event_name}_"


  # Returns the event that the given callback listens to.
  @callback_event_name: (callback_name, field) ->
    callback_name.substring field.length + 4


  # Returns whether the given string starts with the given string.
  @string_starts_with: (string, start) ->
    string.substring(0, start.length) is start



module?.exports = Autobind
window?.Autobind = Autobind

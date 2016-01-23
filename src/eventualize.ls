# Automatically binds all events fired by properties of this class
# to their corresponding "on[property name][method name]" methods.
eventualize = (that) ->
  [fields, callbacks] = eventualize.categorize-members that
  for field in fields
    for callback in callbacks
      if eventualize.is-callback-for callback, field
        that[field].on eventualize.callback-event-name(callback, field),
                       that[callback]

  # Prevent inefficient JavaScript.
  undefined


# Returns all the fields and all callbacks of the current instance.
#
# Callbacks are methods that begin with 'on'.
eventualize.categorize-members = (that) ->
  fields = []
  callbacks = []
  for element of that
    switch typeof that[element]
      when 'object'
        fields.push element
      when 'function'
        callbacks.push element if eventualize.is-callback-method element
  [fields, callbacks]


# Returns whether the method with the given name is a callback method.
eventualize.is-callback-method = (method-name) ->
  eventualize.string-starts-with method-name, 'on'


# Returns whether the method with the given name
# is a callback for the event with the given name.
eventualize.is-callback-for = (method-name, event-name) ->
  eventualize.string-starts-with method-name, "on#{event-name}"


# Returns the event that the given callback listens to.
eventualize.callback-event-name = (callback-name, field) ->
  callback-name.substring field.length + 4


# Returns whether the given string starts with the given string.
eventualize.string-starts-with = (string, start) ->
  string.substring(0, start.length) is start



module?.exports = eventualize
window?.eventualize = eventualize

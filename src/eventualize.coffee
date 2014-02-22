# Automatically binds all events fired by properties of this class
# to their corresponding "on_[property name]_[method name]" methods.
eventualize = (that) ->
  [fields, callbacks] = eventualize.categorize_members that
  for field in fields
    for callback in callbacks
      if eventualize.is_callback_for callback, field
        that[field].on eventualize.callback_event_name(callback, field),
                       that[callback]

  # Prevent inefficient JavaScript.
  undefined


# Returns all the fields and all callbacks of the current instance.
#
# Callbacks are methods that begin with 'on_'.
eventualize.categorize_members = (that) ->
  fields = []
  callbacks = []
  for element of that
    switch typeof that[element]
      when 'object'
        fields.push element
      when 'function'
        callbacks.push element if eventualize.is_callback_method element
  [fields, callbacks]


# Returns whether the method with the given name is a callback method.
eventualize.is_callback_method = (method_name) ->
  eventualize.string_starts_with method_name, 'on_'


# Returns whether the method with the given name
# is a callback for the event with the given name.
eventualize.is_callback_for = (method_name, event_name) ->
  eventualize.string_starts_with method_name, "on_#{event_name}_"


# Returns the event that the given callback listens to.
eventualize.callback_event_name = (callback_name, field) ->
  callback_name.substring field.length + 4


# Returns whether the given string starts with the given string.
eventualize.string_starts_with = (string, start) ->
  string.substring(0, start.length) is start



module?.exports = eventualize
window?.eventualize = eventualize

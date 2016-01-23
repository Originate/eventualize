require! {
  'decamelize'
  'uppercamelcase'
}


# Automatically binds all events fired by properties of this class
# to their corresponding "on[property name][method name]" methods
eventualize = (obj) !->
  [fields, callbacks] = eventualize.categorize-members obj
  for field in fields
    for callback in callbacks
      if eventualize.is-callback-for callback, field
        obj[field].on eventualize.callback-event-name(callback, field),
                       obj[callback]


# Returns all the fields and all callbacks of the current instance
#
# Callbacks are methods that begin with 'on'
eventualize.categorize-members = (obj) ->
  fields = []
  callbacks = []
  for element of obj
    switch typeof obj[element]
      | 'object'    =>  fields.push element
      | 'function'  =>  callbacks.push element if eventualize.is-callback-method element
  [fields, callbacks]


# Returns whether the method with the given name is a callback method
eventualize.is-callback-method = (method-name) ->
  method-name.starts-with 'on'


# Returns whether the method with the given name
# is a callback for the event with the given name
eventualize.is-callback-for = (method-name, event-name) ->
  method-name.starts-with "on#{uppercamelcase event-name}"


# Returns the event that the given callback listens to
eventualize.callback-event-name = (callback-name, field) ->
  decamelize callback-name.substring(field.length + 2), '-'



module?.exports = eventualize
window?.eventualize = eventualize

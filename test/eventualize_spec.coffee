# For testing browser-side export behavior.
global.window = {}

Eventualize = require '../src/eventualize'


# Helper class for testing.
class ButtonClickTester extends Eventualize

  constructor: ->

    # A field.
    @button =
      on: sinon.stub()

  # An event handler for the 'button' field.
  on_button_click: ->

  # A random other method.
  other_method: ->


describe 'Eventualize', ->

  beforeEach ->
    @button_click_tester = new ButtonClickTester()


  describe 'eventualize', ->

    beforeEach ->
      @button_click_tester.eventualize()

    it 'binds events according to their name', ->
      expect(@button_click_tester.button.on).to.have.been.calledWith 'click',
                                                                     @button_click_tester.on_button_click

    it 'binds each method exactly once', ->
      expect(@button_click_tester.button.on).to.have.been.calledOnce


  describe 'callback_event_name', ->

    beforeEach ->
      @result = Eventualize.callback_event_name 'on_button_click', 'button'

    it 'returns the name of the event that the given callback listens to', ->
      expect(@result).to.equal 'click'


  describe 'categorize_members', ->

    beforeEach ->
      [@fields, @callbacks] = @button_click_tester.categorize_members()

    it 'returns the names of all the fields of the object', ->
      expect(@fields).to.eql ['button']

    it 'returns the names of all the callbacks of the object', ->
      expect(@callbacks).to.eql ['on_button_click']

    it 'does not return methods that are not callbacks', ->
      expect(@callbacks).to.not.include 'other_method'


  describe 'is_callback_method', ->

    it 'returns TRUE for callback methods', ->
      expect(Eventualize.is_callback_method 'on_foo_click').to.be.true

    it 'returns FALSE for methods that are not callbacks', ->
      expect(Eventualize.is_callback_method 'foo_bar').to.be.false


  describe 'is_callback_for', ->

    it 'returns TRUE if the given method name is for a callback for the given element', ->
      expect(Eventualize.is_callback_for 'on_button_', 'button').to.be.true

    it 'returns FALSE if the given method name is a callback for a different element', ->
      expect(Eventualize.is_callback_for 'on_foo_', 'button').to.be.false


describe 'starts_with', ->

  it 'returns TRUE if the given string starts with the given string', ->
    expect(Eventualize.string_starts_with 'one two three', 'one').to.be.true

  it 'returns TRUE if the given string is equal to the given string', ->
    expect(Eventualize.string_starts_with 'one', 'one').to.be.true

  it 'returns false if the given string does not start with the given string', ->
    expect(Eventualize.string_starts_with 'one two three', 'two').to.be.false

  it 'returns false if the given string does not start with the given string', ->
    expect(Eventualize.string_starts_with 'on', 'one').to.be.false


describe 'exporting', ->

  it 'exports the Eventualize class as a Node module', ->
    expect(Eventualize).to.not.be.undefined

  it "exports the Eventualize class to the browser's window object", ->
    expect(window.Eventualize).to.not.be.undefined



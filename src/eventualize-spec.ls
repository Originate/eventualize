require! {
  '..' : eventualize
  'chai'
  'sinon'
  'sinon-chai'
}
expect = chai.expect
chai.use sinon-chai


# Helper class for testing.
class ButtonClickTester

  ->
    @button = on: sinon.stub()

    eventualize this

  on-button-click: ->

  other-method: ->



describe 'Eventualize', ->

  before-each ->
    @button-click-tester = new ButtonClickTester()


  describe 'eventualize', (...) ->

    it 'binds matching events', ->
      expect(@button-click-tester.button.on).to.have.been.calledWith 'click',
                                                                     @button-click-tester.on-button-click

    it 'binds each method exactly once', ->
      expect(@button-click-tester.button.on).to.have.been.calledOnce


  describe 'callback-event-name', (...) ->

    it 'returns the name of the event that the given callback listens to', ->
      result = eventualize.callback-event-name 'onButtonClick', 'button'
      expect(result).to.equal 'click'

    it 'works for complex names', ->
      result = eventualize.callback-event-name 'onMyButtonLongPress', 'myButton'
      expect(result).to.equal 'long-press'


  describe 'categorize-members', (...) ->

    beforeEach ->
      [@fields, @callbacks] = eventualize.categorize-members @button-click-tester

    it 'returns the names of all the fields of the object', ->
      expect(@fields).to.eql ['button']

    it 'returns the names of all the callbacks of the object', ->
      expect(@callbacks).to.eql ['onButtonClick']

    it 'does not return methods that are not callbacks', ->
      expect(@callbacks).to.not.include 'otherMethod'


  describe 'is-callback-method', (...) ->

    it 'returns TRUE for callback methods', ->
      expect(eventualize.is-callback-method 'onFooClick').to.be.true

    it 'returns FALSE for methods that are not callbacks', ->
      expect(eventualize.is-callback-method 'fooBar').to.be.false


  describe 'is-callback-for', (...) ->

    it 'returns TRUE if the given method name is for a callback for the given element', ->
      expect(eventualize.is-callback-for 'onButton', 'button').to.be.true

    it 'returns FALSE if the given method name is a callback for a different element', ->
      expect(eventualize.is-callback-for 'onFoo', 'button').to.be.false

messagesSince = ->
  since = moment().subtract(@since, @unit).toDate()
  Messages.find
    group: @group
    updated: $gte: since
  ,
    sort: [['updated', 'desc']]

Template.since.helpers
  messages: messagesSince
  messageCount: ->
    messagesSince.call(@).count()
  activeUnit: (unit) ->
    if @unit == unit
      'active'
    else
      ''
  valid: ->
    parseInt(@since) > 0 and @unit in units

Template.since.events
  'click .unitSelect': (e, t) ->
    console.log
      group: @group
      since: @since
      unit: e.target.getAttribute 'data-unit'
    Router.go 'since',
      group: @group
      since: @since
      unit: e.target.getAttribute 'data-unit'

Template.readMessage.helpers
  formatTitle: ->
    sanitizeHtml formatTitle @format, @title
  formatBody: ->
    sanitizeHtml formatBody @format, @body
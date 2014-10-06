Template.welcome.loading = ->
  Session.get('loading')

Template.welcome.rendered = -> 
  Session.set('loading', 0)
  $('#loadingModal').modal('show')
  interval = Meteor.setInterval(
    -> 
      Session.set('loading', Session.get('loading') + 10)
    600
  )
  
  Tracker.autorun (c) ->
    if Session.get('ready')
      $('#loadingModal').modal('hide')
      Meteor.clearInterval(interval)
      c.stop()
      
  

Template.welcome.current_lang = (lang) ->
  'active' if lang is i18n.getLanguage()

Template.welcome.events
  'click .set-lang': (e,t) ->
    i18n.setLanguage(e.target.id)
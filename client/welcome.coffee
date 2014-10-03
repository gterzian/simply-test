Template.welcome.rendered = -> 
  $('#loadingModal').modal('show')
  Meteor.setInterval(
    -> 
      current = Number($('#loader').css('width').split('%')[0])
      $('#loader').css('width', "#{current + 5}%")
    100
  )
  
  Tracker.autorun (c) ->
    if Session.get('ready')
      $('#loadingModal').modal('hide')
      c.stop()
  

Template.welcome.current_lang = (lang) ->
  'active' if lang is i18n.getLanguage()

Template.welcome.events
  'click .set-lang': (e,t) ->
    i18n.setLanguage(e.target.id)
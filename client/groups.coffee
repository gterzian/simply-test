

Template.groups.groups = ->
  groups.find()

Template.groups.active = (group_id) ->
  if Session.get('group')
    if group_id is Session.get('group')
      'active' 


Template.groups.events
  'click #add_group': (e,t) ->
    e.preventDefault()
    if t.find("#title").value
      _id = groups.insert
        description: t.find("#description").value
        title: t.find("#title").value
        managers:  [Meteor.userId()]
        time: Number(t.find("#time").value)
      t.find("#title").value = ''
      t.find("#description").value = ''
      $('#new_listing').click()
      Session.set('group', _id)
      
  'click .select_group': (e,t) ->
    e.preventDefault()
    Session.set('group', e.target.id)
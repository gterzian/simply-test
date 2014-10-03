

Template.conversations.conversations = ->
  conversations.find()

Template.conversations.chatting = (id) ->
  Session.get('chatting') is id
  
Template.conversations.new_chat = (id) ->
  not _.contains(conversations.findOne(id).watched, Meteor.userId())

Template.conversations.get_user = (chat) ->
  Meteor.users.findOne(_id:chat.sender).username
    
Template.conversations.chats = ->
  chats.find(conversation:Session.get('group'))
  
Template.conversations.events
  'click #send_chat': (e, t) ->
    e.preventDefault()
    if t.find("#content").value
      console.log(Session.get('group'))
      chats.update
        sender: Meteor.userId()  
        content: t.find("#content").value
        time: new Date().getTime()
        conversation: Session.get('group')
      t.find("#content").value = ''
    
  'click .accordion': (e, t) ->
    conversation_id = e.target.hash[1...]
    Session.set('chatting', conversation_id)
    conversations.update(conversation_id, 
      $addToSet: 
        watched: Meteor.userId()
      )
  
Session.setDefault('choices', [])
Session.setDefault('started', false)

Template.items.group = ->
  groups.findOne(_id:Session.get('group'))

Template.items.manager = (group) ->
  Meteor.userId() in groups.findOne(group).managers

Template.items.items = ->
  items.find(group:Session.get('group'))
  
Template.items.choices = ->
  Session.get('choices')

Template.items.started = (test) ->
  test._id is Session.get('started')

Template.items.started_another = (test) ->
  unless test._id is Session.get('started')
    Session.get('started')
    
Template.items.total_questions = ->
  items.find(group:Session.get('group')).count()

Template.items.percent_right = ->
  percent = (Number(tries.findOne(Session.get('current_try')).points) / items.find(group:Session.get('group')).count()) * 100
  "#{percent}%"
  
Template.items.current_try = ->
  tries.findOne(Session.get('current_try'))

Template.items.answered = (question)->
  if Session.get('current_try')
    question._id in tries.findOne(Session.get('current_try')).answered

Template.items.answer_for = (question)->
  answer_for(question)

Template.items.answered_correctly = (question) ->
  answer_for(question) is question.answer
  
Template.items.total_tries = (group) ->
  tries.find(group:group._id, userId:Meteor.userId()).count()

Template.items.all_user_tries = (group) ->
  tries.find(group:group._id, userId:{$not:Meteor.userId()}).count()


      
answer_for = (question) ->
  if Session.get('current_try')
    tried = tries.findOne(Session.get('current_try'))
    if question._id in tried.answered
      answers = _.object(tried.answered, tried.answers)
      answers[question._id]


Template.items.events = 
  'click .start': (e,t) ->
    Session.set('started', e.target.id)
    group = groups.findOne(Session.get('group'))
    current_try = tries.insert
      group: Session.get('group')
      userId: Meteor.userId()
      time: group.time
      answered: []
      answers: []
      points: 0
      result: ''
    Session.set('current_try', current_try)
    ###
    Meteor.setInterval(
      -> tries.update(current_try, {$inc: {time:-1}}), 
      60000
    )
    ###
  
  'click .stop': (e,t) ->
    Session.set('current_try', null)
    Session.set('started', null)

  'click #add_item': (e,t) ->
    e.preventDefault()
    if t.find("#item_title").value
      id = items.insert
        title: t.find("#item_title").value
        group:  Session.get('group')
        choices: Session.get('choices')
        answer: t.find("#answer").value
      t.find("#item_title").value = ''
      $('#add_item').click()
      $("[href='##{id}']").click()
      Session.set('choices', [])
  
  'click #add_choice': (e,t) ->
    Session.set('choices', _.union(Session.get('choices'), [t.find("#new_choice").value]))
    t.find("#new_choice").value = ''
  
  'click .choose_answer': (e,t) ->
    chosen = t.find("#chosen#{e.target.id}").value
    item = items.findOne(e.target.id)
    point = if chosen is item.answer then 1 else 0
    tries.update(
      Session.get('current_try'),
      $addToSet:
        answered: e.target.id
        answers: chosen
      $inc:
        points:
          point
    )
  
  'click .undo_answer': (e,t) ->
    question = items.findOne(e.target.id)
    answer = answer_for(question)
    tries.update(
      Session.get('current_try'),
      $pull:
        answered:
          question._id
        answers:
          answer
    )
Template.profile.username = () ->
  unless Meteor.user() == undefined
    name = Meteor.user().profile.name
    if name == null
      return "click on this to edit"
    name

Template.profile.events =
  'click #name' : () ->
     id = "#name"
     name = Meteor.user().profile.name
     $(id).replaceWith("<input id='name' type='text' value='#{name}'/>")
     $(id).focus()
     $(id).blur(() ->
       $(id).replaceWith("<dd id='name'>#{Template.user.username()}</dd>")
     )
   'keydown input' : (e) ->
     console.log(e.target)   
     if e.which == 13
        switch(e.target.type)
          when 'text'
            Meteor.users.update({_id: Meteor.user()._id}, {$set: {"profile.name": e.target.value}})
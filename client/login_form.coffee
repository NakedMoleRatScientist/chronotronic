Template.login_form.events =
  'click #login-github' : () ->
    Meteor.loginWithGithub({requestPermissions: []}, (err) ->
      if err
        console.log(err)
      else
        Meteor.go("/dashboard")
    )
  'click #login-twitter' : () ->
    Meteor.loginWithTwitter({requestPermissions: []}, (err) ->
      if err
        console.log(err)
      else
        Meteor.go("/dashboard")
    )

Template.login_form.events =
  'click #login' : () ->
    Meteor.loginWithGithub({requestPermissions: []}, (err) ->
      if err
        console.log(err)
      else
        Meteor.go("/dashboard")
    )

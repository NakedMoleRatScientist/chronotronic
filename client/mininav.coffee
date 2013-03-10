Template.mininav = () ->
  switch Session.get("mininav")
    when 0
      ("#events").addClass("active")
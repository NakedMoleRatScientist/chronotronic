Template.stats.rendered = () ->
  width = 800
  height = 600

  svg = d3.select("#svg")
  .append("svg")
  .attr("width",width)
  .attr("height",height)

  colors = [
    "#ffffd9",
    "#edf8b1",
    "#c7e9b4",
    "#7fcdbb",
    "#41b6c4",
    "#1d91c0",
    "#225ea8",
    "#253494",
    "#081d58"
  ]

  last_4_weeks = []

  for i in [0..3] by 1
    o = total_for_week(i)
    last_4_weeks.push({name: o.name, total: o.total})

  svg.selectAll("rect.week")
    .data(last_4_weeks)
    .enter()
    .append("rect")
    .attr("x",10)
    .attr("y",(d,i) ->
      return 50 + 70 * i
    )
    .attr("width",50)
    .attr("height",50)
    .attr("fill",(d) ->
      if d.total <= 40
        which = Math.floor(d.total / 5)
        return colors[which]
      else
        return colors[7]
    )

    svg.selectAll("text.week")
    .data(last_4_weeks)
    .enter()
    .append("text")
    .attr("x",10)
    .attr("y",(d,i) ->
      return 70 + 70 * i
    )
    .text((d)->
      d.name
    )
    .attr("fill", "black")
    .attr("font-size", "20px")
    .attr("font-family", "sans-serif")

    days = get_week(0)
    days = days.concat(get_week(1),get_week(2),get_week(3))
    
    
    svg.selectAll("rect.days")
    .data(days)
    .enter()
    .append("rect")
    .attr("x",(d,i) ->
      n = i % 7
      return 26 * n + 100
     )
    .attr("y",(d,i) ->
      times = Math.floor(i / 7)
      return 70 * (1 + times)
    )
    .attr("width", 25)
    .attr("height", 25)
    .attr("fill","black")
    

Template.stats.total_hours = () ->
  seconds = 0
  events = Events.find({user_id: Meteor.userId()})
  events.forEach((e) ->
    seconds += e.seconds
  )
  (seconds / 3600).toFixed(2)

Template.stats.last_page = () ->
  return true if Session.get("weeknav") == 0

Template.stats.week_of = () ->
  formatDate(week_of(Session.get("weeknav")))

Template.stats.this_week = () ->
  dates = get_week(Session.get("weeknav"))
  newdates = []
  for d in dates
    newdates.push(date: d.date, total: d.total.toFixed(2))
  newdates  

total_for_week = (n = Session.get("weeknav")) ->
  seconds = 0
  dates = get_week(n)
  dates.forEach((d) ->
    seconds += d.total
  )
  name = dates[0].date
  (name: name, total: seconds.toFixed(2))

Template.stats.total_for_week = () ->  
  total_for_week().total
    
Template.stats.size = () ->
  Events.find({user_id: Meteor.userId()}).count()

Template.stats.events =
  'click #previous' : () ->
    d = Session.get("weeknav")
    d += 1
    Session.set("weeknav", d)
  'click #next' : () ->
    d = Session.get("weeknav")
    d += -1
    Session.set("weeknav", d)
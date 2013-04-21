Template.stats.total_hours = () ->
  seconds = 0
  events = Events.find({user_id: Meteor.userId()})
  events.forEach((e) ->
    seconds += e.seconds
  )
  (seconds / 3600).toFixed(2)

Template.stats.today_hours = () ->
  seconds = 0
  start = moment().startOf("day")._d
  end = moment().endOf("day")._d
  events = Events.find({user_id: Meteor.userId(), date: {$gte: start, $lt: end} })
  events.forEach((e) ->
    seconds += e.seconds
  )
  (seconds / 3600).toFixed(2)

Template.stats.size = () ->
  Events.find({user_id: Meteor.userId()}).count()

week = () ->
  endWeek = moment().endOf("day")._d
  beginWeek = moment().subtract("days",7).startOf("day")._d
  events = Events.find({user_id: Meteor.userId(), date: {$gte: beginWeek, $lt: endWeek}})

data: () ->
  cos = []
  sin = []        

  for i in [1..100]
    sin.push({x: i, y: Math.sin(i/10)})
    cos.push({x: i, y: .5 * Math.cos(i/10)})

  return [
    {
      values: sin,
      key: 'Sine Wave',
      color: '#ff7f0e'
    },
    {
      values: cos,
      key: 'Cosine Wave',
      color: '#2ca02c'
    }
  ]


nv.addGraph(() ->
  chart = nv.models.lineChart()
  chart.xAxis.axisLabel('Date').tickFormat(d3.format(',r'))
  chart.yAxis.axisLabel('Hours').tickFormat(d3.format(',r'))
  d3.select("#chart svg").datum(data()).transition().duration(500).call(chart)
)
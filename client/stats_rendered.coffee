Template.stats.rendered = () ->
  width = 500
  height = 350

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
    .attr("stroke",(d) ->
      which = Math.floor(d.total / 5)
      if which == 0
        return "black"
    )
    svg.selectAll("text.week")
    .data(last_4_weeks)
    .enter()
    .append("text")
    .attr("x",13)
    .attr("y",(d,i) ->
      return 70 + 70 * i
    )
    .text((d)->
      name = d.name.split("-")
      return name[1] + "-" + name[2]
    )
    .attr("fill", "black")
    .attr("font-size", "15px")
    .attr("font-family", "sans-serif")

    days = get_week(0)
    days = days.concat(get_week(1),get_week(2),get_week(3))
    
    svg.selectAll("rect.days")
    .data(days)
    .enter()
    .append("rect")
    .attr("x",(d,i) ->
      n = i % 7
      return 30 * n + 100
     )
    .attr("y",(d,i) ->
      times = Math.floor(i / 7)
      return 70 * (1 + times)
    )
    .attr("width", 25)
    .attr("height", 25)
    .attr("fill",(d,i) ->
      which = Math.floor(d.total)
      if which >= 8
        return colors[7]
      else
        return colors[which]
    )
    .attr("stroke",(d,i) ->
      which = Math.floor(d.total)
      if which == 0
        return "black"
    )
    .on("click",(d) ->
      console.log(Math.floor(d.total))
    )

    

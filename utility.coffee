String.prototype.toTime = () ->
  sec_numb = parseInt(this)
  hours = Math.floor(sec_numb / 3600)
  minutes = Math.floor((sec_numb - (hours * 3600)) / 60)
  seconds = sec_numb - (hours * 3600) - (minutes * 60)

  hours = "0" + hours if hours < 10
  minutes = "0" + minutes if minutes < 10
  seconds = "0" + seconds if seconds < 10
  time = hours + ':' + minutes + ':' + seconds

format_date = (day,month,year) ->
  if day < 10
    day = "0" + day
  if month < 10
    month = "0" + month
  year + "-" + month + '-' day

getTodayDate = () ->
  date = new Date()
  day = date.getDate()
  month = date.getMonth() + 1
  year = date.getFullYear()
  format_date(day,month,year)

getDate = (i) ->
  date = new Date()
  day = date.getDate() - i
  month = date.getMonth() + 1
  year = date.getFullYear()
  format_date(day,month,year)

previousDays = (n) ->

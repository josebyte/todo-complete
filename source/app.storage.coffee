__.storage = (key, value) ->
  if value
    localStorage.setItem key, JSON.stringify(value)
  else
    value = JSON.parse localStorage.getItem key
  value

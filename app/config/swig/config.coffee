swigFilters =
  linebreaksbr: (input)-> Pathwright.utils.convertBreaks(input)
  pluralize: (input, count)->
    pluralize(input, count)
  date_from_now: (input)-> moment(input).fromNow()
  slice: (input, args...)->
    if args.length is 1
      input[args[0]..]
    else
      input[args[0]..args[1]]
  # striptags courtesy of http://stackoverflow.com/questions/822452/strip-html-from-text-javascript
  striptags: (input)->
    tmp = document.createElement "div"
    tmp.innerHTML = input
    tmp.textContent || tmp.innerText || ""
  truncate: (input, int)->
    if input.length > int
      input[0..int] + "\u2026"
    else
      input
  length: (input)->
    input.length
  floatformat: (input, precision=2)->
    input.toFixed(precision)
  currencyformat: (input)->
    numeral(input).format("$0,0[.]00")

for key, func of swigFilters
  swig.setFilter(key, func)
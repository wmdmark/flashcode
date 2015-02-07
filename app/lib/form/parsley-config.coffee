module.exports =
  successClass: 'has-success'
  errorClass: 'has-error'
  animateDuration: 0
  validateIfUnchanged: yes
  validators:
    ace: (val, el, field)->
      editor = $(el).data("editor")
      val = editor.getValue()
      return val.length > 0
    slug: (val, el, field)=>
      urlregex = /^[a-zA-Z0-9-_]+$/
      return urlregex.test(val)
    errors:
      errorsWrapper: "<div class='error'></div>"
      errorElem: "<span class='error'></span>"    


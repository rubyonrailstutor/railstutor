class window.Validation

  validatePresence: () ->
    select = $(".validates-presence")
    if select.length is 0
      return true
    if select.length > 0
      errors = 0
      $("input.validates-presence").each ( index, element ) =>
        if $(element).val().length isnt 0 && $(element).hasClass("error")
          $(element).removeClass("error")
        if $(element).val().length is 0
          $(element).addClass("error")
          mixpanel.track "emptyInput", emptyId: element.id
          @presenceErrorRelease(element)
          errors += 1
    if errors is 0
      return true
    else
      return false

  presenceErrorRelease: (element) ->
    $(element).focus =>
      $(element).blur ->
        if $(element).val().length isnt 0 && $(element).hasClass("error")
          $(@).removeClass("error")

validate_form = () ->
  $("#checkout").click ->
    if validate_presence() is "valid" 
      newStudentEmail = $("#newStudentEmail").val()
      newStudentName = $("#newStudentName").val()
      console.log "stripe clicked"
      number = $('#card-number').val()
      cvc = $('#card-cvc').val()
      exp_month = $('#card-month').val()
      exp_year= $('#card-year').val()
      console.log number, cvc, exp_month, exp_year
      Stripe.card.createToken(
        number: number 
        cvc: cvc 
        exp_month: exp_month 
        exp_year: exp_year 
      , 
        (response) -> 
         console.log response
      )
      # $.ajax
      #   type: "POST"
      #   url: "/main.json"
      #   data: {
      #     email: newStudentEmail 
      #     name: newStudentName 
      #   }
      #   success: (json_data) ->
      #     if json_data.response isnt null
      #       message = "Welcome " + json_data.response
      #     $("#ResponseEmail").text(message)
      #     $("#thankyou").foundation('reveal', 'open')
    else
      return

validate_presence = ->
  select = $(".validates_presence")
  if select.length is 0
    return 'valid'
  if select.length > 0
    errors = 0
    $("input.validates_presence").each ( index, element ) ->
      if $(element).val().length isnt 0 && $(element).hasClass("error")
        $(element).removeClass("error")
      if $(element).val().length is 0
        $(element).addClass("error")
        presence_error_release(element)
        errors += 1
  if errors is 0
    return "valid"
  else
    return "invalid"

presence_error_release = (element) ->
  $(element).focus ->
    $(element).blur ->
      if $(element).val().length isnt 0 && $(element).hasClass("error")
        $(@).removeClass("error")

validate_form()

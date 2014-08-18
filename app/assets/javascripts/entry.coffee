toggle_judging_times = ->
  if $("#entry_skill_level").val().toLowerCase().indexOf('exhibition') > -1
    $("#entry_judging_time_id_available").addClass('hidden')
    $("#entry_judging_time_id_unavailable").removeClass('hidden')
  else
    $("#entry_judging_time_id_available").removeClass('hidden')
    $("#entry_judging_time_id_unavailable").addClass('hidden')
  return

ready = ->
  toggle_judging_times()
  $("#entry_skill_level").change( ->
    toggle_judging_times()
  )

$(document).ready(ready)

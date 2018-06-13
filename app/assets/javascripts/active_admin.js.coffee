#= require active_admin/base
#= require best_in_place
#= require jquery.colorbox-min
#= require_tree ./admin
$(document).ready ->
  jQuery(".best_in_place").best_in_place()
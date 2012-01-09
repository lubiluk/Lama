# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

#
# Map resize
#
$(window).resize ->
  $("#map_canvas").width($(window).width()-240).height($(window).height()-40);

$(document).ready ->

  # Fire resize event
  $(window).trigger('resize')
  
  # Initial position
  myLatlng = new google.maps.LatLng(50.0, 22.0);
  
  
  # Map options
  myMapTypeControlOptions = 
      mapTypeIds : [google.maps.MapTypeId.ROADMAP, google.maps.MapTypeId.SATELLITE]
      style : google.maps.MapTypeControlStyle.DROPDOWN_MENU
  myOptions = 
      zoom: 5
      center: myLatlng
      mapTypeId: google.maps.MapTypeId.ROADMAP
      mapTypeControlOptions : myMapTypeControlOptions
     
  # Load map
  map = new google.maps.Map($("#map_canvas").get(0), myOptions);
# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

#
# Map resize
#
$(window).resize ->
  $("#map_canvas").width($(window).width()-290).height($(window).height()-40);

$(document).ready ->

  # Fire resize event on load
  $(window).trigger('resize')
  
  # Initial position
  myLatlng = new google.maps.LatLng(50.0, 20.0);
  
  
  # Map options
  myMapTypeControlOptions = 
      mapTypeIds : [google.maps.MapTypeId.ROADMAP, google.maps.MapTypeId.SATELLITE]
      style : google.maps.MapTypeControlStyle.DROPDOWN_MENU
  myOptions = 
      zoom: 3
      center: myLatlng
      mapTypeId: google.maps.MapTypeId.ROADMAP
      mapTypeControlOptions : myMapTypeControlOptions
     
  # Load map
  map = new google.maps.Map($("#map_canvas").get(0), myOptions);
  
  # Load points
  $.getJSON("/point_marks.json", (data) -> 
    
    $.each(data, (key, item) ->
      if(item.the_geom)
        x = item.the_geom.x
        y = item.the_geom.y
        latLng = new google.maps.LatLng(20, 55);
        
        marker = new google.maps.Marker({
                position: latLng,
                map: map,
                draggable : true
        });
      return
    )      
      
    return
  )
  
  
  # do not return 
  return

#
# Map resize
#
$(window).resize ->
  $("#map_canvas").width($(window).width()-290).height($(window).height()-40);

$(document).ready ->
  
  #currently edited geometry declaration
  edited_geometry = null
  
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
  
  #On map view change
  google.maps.event.addListener(map, "zoom_changed", ->
    x = map.getCenter().lat()
    y = map.getCenter().lng()
    zoom = map.getZoom()
    
    data = JSON.stringify({
      zoom: zoom,
      x: x,
      y: y
    })
    
    $.ajax({
      type : "PUT",
      url : "/map_states/1.json",
      data : data,
      dataType : "json",
      contentType: "application/json"
    })
  )
  google.maps.event.addListener(map, "dragend", ->
    
  )
  
  # Load map state
  $.getJSON("/map_states/1.json", (data) ->
     map.setZoom(data.zoom)
     map.setCenter(new google.maps.LatLng(data.x, data.y))
     return
  )
  
  
  # Load all geometries
  $.getJSON("/geometry_marks.json", (data) -> 
    
    $.each(data, (key, item) ->
      if(item.the_geom)
        id = item.id
        layer_id = item.layer_id
        name = item.name
        radius = item.radius
        geom = item.the_geom
        
        switch layer_id
          when 1
            #point
            x = geom.x
            y = geom.y
          
            LatLng = new google.maps.LatLng(x, y);
            
            marker = new google.maps.Marker({
              position: LatLng,
              map : map,
              draggable : false
            });
          
          when 2
            #polygon
            alert("polygon")
          
          when 3
            #circle
            #center
            x = geom.x
            y = geom.y
          
            LatLng = new google.maps.LatLng(x, y);
            
            circleOptions = {
                  center : LatLng,
                  radius: radius,
                  map : map,
                  strokeColor : "#0000FF",
                  fillColor : "#0000FF"
                }
    
            circle = new google.maps.Circle(circleOptions)            
            
            
      return
    )      
      
    return
  )
  
  
  # enable edit mode
  enableEditMode = (geometry) -> 
    edited_geometry = geometry
    $("#menu").hide()
    $("#edit_mode").show()
    return
      
  # attach events
  
  # add point
  $(".add_point").live("click", (event) ->
    marker = new google.maps.Marker({
      position: map.getCenter(),
      map : map,
      draggable : true
    });
    
    geometry = {
      type : "point",
      layer_id : 1,
      geom : marker
    }
    
    enableEditMode(geometry)
    
    return
  )
  
  #add circle
  $(".add_circle").live("click", (event) ->
    circleOptions = {
      center : map.getCenter(),
      radius: 1000,
      map : map,
      strokeColor : "#0000FF",
      fillColor : "#0000FF"
      editable : true
    }
    
    circle = new google.maps.Circle(circleOptions)
    
    geometry = {
      type : "circle",
      layer_id : 3,
      geom : circle
    }
    
    enableEditMode(geometry)    
    
    return
  )
  
  #add polygon
  $(".add_polygon").live("click", (event) ->
    
  )
  
  # save geometry
  $("#save_geometry").live("click", (event) ->
    if edited_geometry != null
      type = edited_geometry.type
      layer_id = edited_geometry.layer_id
      geom = edited_geometry.geom
      
      switch type
        when "circle"
          x = geom.getCenter().lat()
          y = geom.getCenter().lng()
          wkt = "POINT(" + x + " " + y + ")"
          data = JSON.stringify({
            name : "json circle",
            layer_id : 3,
            radius : geom.getRadius(),
            wkt : wkt
          })
          
          $.ajax({
            type : "POST",
            url : "/geometry_marks.json",
            data : data,
            dataType : "json",
            contentType: "application/json"
          })
          geom.setEditable(false)
        when "point"
          x = geom.getPosition().lat()
          y = geom.getPosition().lng()
          wkt = "POINT(" + x + " " + y + ")"
          data = JSON.stringify({
            name : "json point",
            layer_id : 1,
            wkt : wkt
          })
          
          $.ajax({
            type : "POST",
            url : "/geometry_marks.json",
            data : data,
            dataType : "json",
            contentType: "application/json"
          })
          geom.setDraggable(false)
      
      alert("saved")   
      edited_geometry = null
      
      
    $("#menu").show()
    $("#edit_mode").hide()      
    
    return
  )
  
  
  # do not return anything 
  return

#
# Map resize
#
$(window).resize ->
  $("#map_canvas").width($(window).width()-290).height($(window).height()-40);

$(document).ready ->
  
  #currently edited geometry declaration
  edited_geometry = null
  objects = new Array()
  
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
        
        struct = {layer_id : layer_id}
        
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
            
            struct.obj = marker
          
          when 2
            #polygon
            polygonOptions = {
              editable : false,
              fillColor : "#00FF00",
              strokeColor : "#00FF00",
              map : map     
            }
            
            polygon = new google.maps.Polygon(polygonOptions)
            points = geom.rings[0].points
            path = polygon.getPath()

            $.each(points, (key, point) ->
              x = point.x
              y = point.y
              LatLng = new google.maps.LatLng(x, y);              
              path.push(LatLng)
            )

            struct.obj = polygon

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
            
            struct.obj = circle

        objects.push(struct)
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
    polygonOptions = {
      editable : true,
      fillColor : "#00FF00",
      strokeColor : "#00FF00",
      map : map     
    }
    
    polygon = new google.maps.Polygon(polygonOptions)
    
    geometry = {
      type : "polygon",
      layer_id : 2,
      geom : polygon
    }
    
    addPoint = (event) ->
      vertices = polygon.getPath()
      vertices.push(event.latLng)
      return
    
    google.maps.event.addListener(map, "click", addPoint)
    
    enableEditMode(geometry)    
    
    
    return
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
        when "polygon"
        
          wkt = "POLYGON(("
          
          first=true
          path = geom.getPath().forEach((event) ->
            lat = event.lat()
            lng = event.lng()
            
            if !first
              wkt += ", "
            wkt += lat + " " + lng
            
            first=false
          )
                    
          wkt +=  "))"
          
          data = JSON.stringify({
            name : "json poly",
            layer_id : 2,
            wkt : wkt
          })
          $.ajax({
            type : "POST",
            url : "/geometry_marks.json",
            data : data,
            dataType : "json",
            contentType: "application/json"
          })
          
          
          google.maps.event.clearListeners(map, "click")
          geom.setEditable(false)
      
      alert(wkt)   
      edited_geometry = null
      
      
    $("#menu").show()
    $("#edit_mode").hide()      
    
    return
  )
  
  #display layer function
  showLayer = (id) ->
    $.each(objects, (key, struct) ->
      if(struct.layer_id == id)
        struct.obj.setMap(map)
    )
  
  #hide layer function
  hideLayer = (id) ->
    $.each(objects, (key, struct) ->
      if(struct.layer_id == id)
        struct.obj.setMap(null)
    )


  
  $("#points-visible").live("click", (event) ->
    $("#points-invisible").show()
    $("#points-visible").hide()
  
    #make points invisible
    hideLayer(1)
  
    return
  )
  
  $("#points-invisible").live("click", (event) ->
    $("#points-visible").show()
    $("#points-invisible").hide()
  
  	#make points visible
    showLayer(1)
    
    return
  )
  
  $("#polygons-visible").live("click", (event) ->
    $("#polygons-invisible").show()
    $("#polygons-visible").hide()
    
    #make polygons invisible
    hideLayer(2)
  
    return
  )
  
  $("#polygons-invisible").live("click", (event) ->
    $("#polygons-visible").show()
    $("#polygons-invisible").hide()
    
    #make polygons visible
    showLayer(2)
  
    return
  )
  
  $("#circles-visible").live("click", (event) ->
    $("#circles-invisible").show()
    $("#circles-visible").hide()
  
  	#make circles invisible
    hideLayer(3)
  
    return
  )
  
  $("#circles-invisible").live("click", (event) ->
    $("#circles-visible").show()
    $("#circles-invisible").hide()
    
    #make circles visible
    showLayer(3)
  
    return
  )
  
  # do not return anything 
  return

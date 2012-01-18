class PolygonMarksController < ApplicationController
    # GET /polygon_marks
    # GET /polygon_marks.json
    def index
        @polygon_marks = PolygonMark.all
        
        respond_to do |format|
            format.html # index.html.erb
            format.json { render :json => @polygon_marks }
        end
    end
    
    # GET /polygon_marks/1
    # GET /polygon_marks/1.json
    def show
        @polygon_mark = PolygonMark.find(params[:id])
        
        respond_to do |format|
            format.html # show.html.erb
            format.json { render :json => @polygon_mark }
        end
    end
    
    # GET /polygon_marks/new
    # GET /polygon_marks/new.json
    def new
        @polygon_mark = PolygonMark.new
        
        respond_to do |format|
            format.html # new.html.erb
            format.json { render :json => @polygon_mark }
        end
    end
    
    # GET /polygon_marks/1/edit
    def edit
        @polygon_mark = PolygonMark.find(params[:id])
    end
    
    # POST /polygon_marks
    # POST /polygon_marks.json
    def create
        @polygon_mark = PolygonMark.new(:name => params[:name], :layer_id => params[:layer_id])
        
        respond_to do |format|
            if @polygon_mark.save
                @polygon_mark.the_geom = Polygon.from_coordinates([params[:coordinates]], 4269)
                @polygon_mark.save!
                format.html { redirect_to @polygon_mark, :notice => 'polygon mark was successfully created.' }
                format.json { render :json => @polygon_mark, :status => :created, :location => @polygon_mark }
                else
                format.html { render :action => "new" }
                format.json { render :json => @polygon_mark.errors, :status => :unprocessable_entity }
            end
        end
    end
    
    # PUT /polygon_marks/1
    # PUT /polygon_marks/1.json
    def update
        @polygon_mark = PolygonMark.find(params[:id])
        
        respond_to do |format|
            if @polygon_mark.update_attributes(:name => params[:name], :layer_id => params[:layer_id])
                @polygon_mark.the_geom = Polygon.from_coordinates(params[:coordinates], 4269)
                @polygon_mark.save!
                format.html { redirect_to @polygon_mark, :notice => 'polygon mark was successfully updated.' }
                format.json { head :ok }
                else
                format.html { render :action => "edit" }
                format.json { render :json => @polygon_mark.errors, :status => :unprocessable_entity }
            end
        end
    end
    
    # DELETE /polygon_marks/1
    # DELETE /polygon_marks/1.json
    def destroy
        @polygon_mark = PolygonMark.find(params[:id])
        @polygon_mark.destroy
        
        respond_to do |format|
            format.html { redirect_to polygon_marks_url }
            format.json { head :ok }
        end
    end
end

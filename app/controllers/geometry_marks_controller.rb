class GeometryMarksController < ApplicationController
  # GET /geometry_marks
  # GET /geometry_marks.json
  def index
    @geometry_marks = GeometryMark.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @geometry_marks }
    end
  end

  # GET /geometry_marks/1
  # GET /geometry_marks/1.json
  def show
    @geometry_mark = GeometryMark.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @geometry_mark }
    end
  end

  # GET /geometry_marks/new
  # GET /geometry_marks/new.json
  def new
    @geometry_mark = GeometryMark.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @geometry_mark }
    end
  end

  # GET /geometry_marks/1/edit
  def edit
    @geometry_mark = GeometryMark.find(params[:id])
  end

  # POST /geometry_marks
  # POST /geometry_marks.json
  def create
    @geometry_mark = GeometryMark.new(params[:geometry_mark])

    respond_to do |format|
      if @geometry_mark.save
        ewkt = "SRID=4269;" + params[:wkt]
        @geometry_mark.the_geom = Geometry.from_ewkt(ewkt)
        @geometry_mark.save!
        format.html { redirect_to @geometry_mark, :notice => 'Geometry mark was successfully created.' }
        format.json { render :json => @geometry_mark, :status => :created, :location => @geometry_mark }
      else
        format.html { render :action => "new" }
        format.json { render :json => @geometry_mark.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /geometry_marks/1
  # PUT /geometry_marks/1.json
  def update
    @geometry_mark = GeometryMark.find(params[:id])

    respond_to do |format|
      if @geometry_mark.update_attributes(params[:geometry_mark])
        ewkt = "SRID=4269;" + params[:wkt]
        @geometry_mark.the_geom = Geometry.from_ewkt(ewkt)
        @geometry_mark.save!
        format.html { redirect_to @geometry_mark, :notice => 'Geometry mark was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @geometry_mark.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /geometry_marks/1
  # DELETE /geometry_marks/1.json
  def destroy
    @geometry_mark = GeometryMark.find(params[:id])
    @geometry_mark.destroy

    respond_to do |format|
      format.html { redirect_to geometry_marks_url }
      format.json { head :ok }
    end
  end
end

class PointMarksController < ApplicationController
  # GET /point_marks
  # GET /point_marks.json
  def index
    @point_marks = PointMark.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @point_marks }
    end
  end

  # GET /point_marks/1
  # GET /point_marks/1.json
  def show
    @point_mark = PointMark.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @point_mark }
    end
  end

  # GET /point_marks/new
  # GET /point_marks/new.json
  def new
    @point_mark = PointMark.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @point_mark }
    end
  end

  # GET /point_marks/1/edit
  def edit
    @point_mark = PointMark.find(params[:id])
  end

  # POST /point_marks
  # POST /point_marks.json
  def create
    @point_mark = PointMark.new(params[:point_mark])

    respond_to do |format|
      if @point_mark.save
        format.html { redirect_to @point_mark, :notice => 'Point mark was successfully created.' }
        format.json { render :json => @point_mark, :status => :created, :location => @point_mark }
      else
        format.html { render :action => "new" }
        format.json { render :json => @point_mark.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /point_marks/1
  # PUT /point_marks/1.json
  def update
    @point_mark = PointMark.find(params[:id])

    respond_to do |format|
      if @point_mark.update_attributes(params[:point_mark])
        format.html { redirect_to @point_mark, :notice => 'Point mark was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @point_mark.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /point_marks/1
  # DELETE /point_marks/1.json
  def destroy
    @point_mark = PointMark.find(params[:id])
    @point_mark.destroy

    respond_to do |format|
      format.html { redirect_to point_marks_url }
      format.json { head :ok }
    end
  end
end

class MapStatesController < ApplicationController
  # GET /map_states
  # GET /map_states.json
  def index
    @map_states = MapState.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @map_states }
    end
  end

  # GET /map_states/1
  # GET /map_states/1.json
  def show
    @map_state = MapState.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @map_state }
    end
  end

  # GET /map_states/new
  # GET /map_states/new.json
  def new
    @map_state = MapState.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @map_state }
    end
  end

  # GET /map_states/1/edit
  def edit
    @map_state = MapState.find(params[:id])
  end

  # POST /map_states
  # POST /map_states.json
  def create
    @map_state = MapState.new(params[:map_state])

    respond_to do |format|
      if @map_state.save
        format.html { redirect_to @map_state, :notice => 'Map state was successfully created.' }
        format.json { render :json => @map_state, :status => :created, :location => @map_state }
      else
        format.html { render :action => "new" }
        format.json { render :json => @map_state.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /map_states/1
  # PUT /map_states/1.json
  def update
    @map_state = MapState.find(params[:id])

    respond_to do |format|
      if @map_state.update_attributes(params[:map_state])
        format.html { redirect_to @map_state, :notice => 'Map state was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @map_state.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /map_states/1
  # DELETE /map_states/1.json
  def destroy
    @map_state = MapState.find(params[:id])
    @map_state.destroy

    respond_to do |format|
      format.html { redirect_to map_states_url }
      format.json { head :ok }
    end
  end
end

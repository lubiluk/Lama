class LayersController < ApplicationController
  # GET /layers
  # GET /layers.json
  def index
    @layers = Layer.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @layers }
    end
  end

  # GET /layers/1
  # GET /layers/1.json
  def show
    @layer = Layer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @layer }
    end
  end

  # GET /layers/new
  # GET /layers/new.json
  def new
    @layer = Layer.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @layer }
    end
  end

  # GET /edit/1/edit
  def edit
    @layer = Layer.find(params[:id])
  end

  # POST /layers
  # POST /layers.json
  def create
    @layer = Layer.new(:name => params[:name], :colour => params[:colour])

    respond_to do |format|
      if @layer.save
        @layer.save!
        format.html { redirect_to @layer, :notice => 'Layer was successfully created.' }
        format.json { render :json => @layer, :status => :created, :location => @layer }
      else
        format.html { render :action => "new" }
        format.json { render :json => @layer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /layers/1
  # PUT /layers/1.json
  def update
    @layer = Layer.find(params[:id])

    respond_to do |format|
      if @layer.update_attributes(:name => params[:name], :colour => params[:colour])
        @layer.save!
        format.html { redirect_to @layer, :notice => 'Layer was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @layer.errors, :status => :unprocessable_entity }
      end
    end
  end


  # DELETE /layers/1
  # DELETE /layers/1.json
  def destroy
    @layer = Layer.find(params[:id])
    @layer.destroy

    respond_to do |format|
      format.html { redirect_to layers_url }
      format.json { head :ok }
    end
  end

end

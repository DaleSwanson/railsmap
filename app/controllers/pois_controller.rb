class PoisController < ApplicationController
  # GET /Pois
  # GET /users.json
  def index
    @poi = Poi.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @poi }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @poi = Poi.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @poi }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @poi = Poi.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @poi }
    end
  end

  # GET /users/1/edit
  def edit
    @poi = Poi.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @poi = Poi.new(params[:poi])

    respond_to do |format|
      if @poi.save
        format.html { redirect_to @poi, notice: 'POI was successfully created.' }
        format.json { render json: @poi, status: :created, location: @poi }
      else
        format.html { render action: "new" }
        format.json { render json: @poi.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @poi = Poi.find(params[:id])

    respond_to do |format|
      if @poi.update_attributes(params[:poi])
        format.html { redirect_to @poi, notice: 'POI was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @poi.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @poi = Poi.find(params[:id])
    @poi.destroy

    respond_to do |format|
      format.html { redirect_to pois_url }
      format.json { head :no_content }
    end
  end
end

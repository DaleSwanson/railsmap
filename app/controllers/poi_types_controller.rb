class PoiTypesController < ApplicationController
  # GET /PoiTypes
  # GET /users.json
  def index
    @poi_type = PoiType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @poi_type }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @poi_type = PoiType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @poi_type }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @poi_type = PoiType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @poi_type }
    end
  end

  # GET /users/1/edit
  def edit
    @poi_type = PoiType.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @poi_type = PoiType.new(params[:poi_type])

    respond_to do |format|
      if @poi_type.save
        format.html { redirect_to @poi_type, notice: 'PoiType was successfully created.' }
        format.json { render json: @poi_type, status: :created, location: @poi_type }
      else
        format.html { render action: "new" }
        format.json { render json: @poi_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @poi_type = PoiType.find(params[:id])

    respond_to do |format|
      if @poi_type.update_attributes(params[:poi_type])
        format.html { redirect_to @poi_type, notice: 'PoiType was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @poi_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @poi_type = PoiType.find(params[:id])
    @poi_type.destroy

    respond_to do |format|
      format.html { redirect_to poi_types_url }
      format.json { head :no_content }
    end
  end
end

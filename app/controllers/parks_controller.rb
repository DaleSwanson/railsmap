class ParksController < ApplicationController
	respond_to :html, :json
	
  # GET /Parks
  # GET /parks.json
  def index
    @park = Park.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @park }
    end
  end

  # GET /parks/1
  # GET /parks/1.json
  def show
    @park = Park.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @park }
    end
  end

  # GET /parks/new
  # GET /parks/new.json
  def new
    @park = Park.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @park }
    end
  end

  # GET /parks/1/edit
  def edit
    @park = Park.find(params[:id])
  end

  # POST /parks
  # POST /parks.json
  def create
    @park = Park.new(params[:park])

    respond_to do |format|
      if @park.save
        format.html { redirect_to @park, notice: 'POI was successfully created.' }
        format.json { render json: @park, status: :created, location: @park }
      else
        format.html { render action: "new" }
        format.json { render json: @park.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /parks/1
  # PUT /parks/1.json
  def update
    @park = Park.find(params[:id])
    @park.update_attributes(params[:park])
    respond_with_bip(@park)
  end
  
  # DELETE /parks/1
  # DELETE /parks/1.json
  def destroy
    @park = Park.find(params[:id])
    @park.destroy

    respond_to do |format|
      format.html { redirect_to parks_url }
      format.json { head :no_content }
    end
  end
end

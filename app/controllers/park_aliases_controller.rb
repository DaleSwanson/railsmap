class ParkAliasesController < ApplicationController
  # GET /ParkAliases
  # GET /users.json
  def index
    @park_alias = ParkAlias.includes(:park).all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @park_alias }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @park_alias = ParkAlias.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @park_alias }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @park_alias = ParkAlias.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @park_alias }
    end
  end

  # GET /users/1/edit
  def edit
    @park_alias = ParkAlias.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @park_alias = ParkAlias.new(params[:park_alias])

    respond_to do |format|
      if @park_alias.save
        format.html { redirect_to @park_alias, notice: 'ParkAlias was successfully created.' }
        format.json { render json: @park_alias, status: :created, location: @park_alias }
      else
        format.html { render action: "new" }
        format.json { render json: @park_alias.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @park_alias = ParkAlias.find(params[:id])

    respond_to do |format|
      if @park_alias.update_attributes(params[:park_alias])
        format.html { redirect_to @park_alias, notice: 'ParkAlias was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @park_alias.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @park_alias = ParkAlias.find(params[:id])
    @park_alias.destroy

    respond_to do |format|
      format.html { redirect_to park_aliases_url }
      format.json { head :no_content }
    end
  end
end

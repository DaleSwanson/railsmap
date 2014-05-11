class PairsController < ApplicationController
  # GET /Pairs
  # GET /users.json
  def index
    @pair = Pair.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pair }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @pair = Pair.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @pair }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @pair = Pair.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @pair }
    end
  end

  # GET /users/1/edit
  def edit
    @pair = Pair.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @pair = Pair.new(params[:pair])

    respond_to do |format|
      if @pair.save
        format.html { redirect_to @pair, notice: 'Pair was successfully created.' }
        format.json { render json: @pair, status: :created, location: @pair }
      else
        format.html { render action: "new" }
        format.json { render json: @pair.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @pair = Pair.find(params[:id])

    respond_to do |format|
      if @pair.update_attributes(params[:pair])
        format.html { redirect_to @pair, notice: 'Pair was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @pair.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @pair = Pair.find(params[:id])
    @pair.destroy

    respond_to do |format|
      format.html { redirect_to pairs_url }
      format.json { head :no_content }
    end
  end
end

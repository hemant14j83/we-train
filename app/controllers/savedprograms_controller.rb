class SavedprogramsController < ApplicationController
  before_action :set_savedprogram, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_trainer!
  # GET /savedprograms
  # GET /savedprograms.json
  def index
    @savedprograms = Savedprogram.all
    @trainer=Trainer.find(current_trainer.id)
    @program=Program.find(:program_id)
  end

  # GET /savedprograms/1
  # GET /savedprograms/1.json
  def show
  end

  # GET /savedprograms/new
  def new
    @savedprogram = Savedprogram.new
  end

  # GET /savedprograms/1/edit
  def edit
  end

  # POST /savedprograms
  # POST /savedprograms.json
  def create
    @trainer=Trainer.find(current_trainer.id)
    @program=Program.find(params[:program_id])
    #@sdprogram=@trainer.savedprograms.build(:program_id=>params[:program_id],:trainer_id=>params[:trainer_id])
    @savedprogram = Savedprogram.new(:program_id=>params[:program_id],:trainer_id=>current_trainer.id)

    respond_to do |format|
      if @savedprogram.save
        format.html { redirect_to "/programs", notice: 'Program Added to Saved List' }
        format.json { render :show, status: :created, location: @savedprogram }
      else
        format.json { render json: @savedprogram.errors, status: :unprocessable_entity }
        redirect_to programs_path
      end
    end
  end

  # PATCH/PUT /savedprograms/1
  # PATCH/PUT /savedprograms/1.json
  def update
    respond_to do |format|
      if @savedprogram.update(savedprogram_params)
        format.html { redirect_to @savedprogram, notice: 'Savedprogram was successfully updated.' }
        format.json { render :show, status: :ok, location: @savedprogram }
      else
        format.html { render :edit }
        format.json { render json: @savedprogram.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /savedprograms/1
  # DELETE /savedprograms/1.json
  def destroy
    @savedprogram.destroy
    respond_to do |format|
      format.html { redirect_to savedprograms_url, notice: 'Savedprogram was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_savedprogram
      @savedprogram = Savedprogram.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def savedprogram_params
      params.require(:savedprogram).permit(:program_id, :trainer_id)
    end
end

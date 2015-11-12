class SavedprogramsController < ApplicationController
  before_action :set_savedprogram, only: [:show, :edit, :update, :destroy, :savedlist]
  before_filter :authenticate_trainer!
  # GET /savedprograms
  # GET /savedprograms.json
  def index
    @savedprograms = Savedprogram.by_status('active').recent
    @deletedprograms = Savedprogram.by_status('deleted').recent
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
    @t_expertise=Expertise.find_by(trainer_id: current_trainer.id,expertise_in: @program.expertise)
    @appliedprogram=Appliedprogram.find_by(program_id: params[:program_id], trainer_id: current_trainer.id)
    #@sdprogram=@trainer.savedprograms.build(:program_id=>params[:program_id],:trainer_id=>params[:trainer_id])
    @savedprogram = Savedprogram.new(:program_id=>params[:program_id],:trainer_id=>current_trainer.id)
    begin
      if @appliedprogram
        flash[:notice]='You have already applied for this program.'
        redirect_to programs_path
      elsif @t_expertise
        if @savedprogram.save
          flash[:notice]='Program added to saved list.'
          redirect_to programs_path
          #format.html { redirect_to "/programs", notice: 'Program Added to Saved List' }
          #format.json { render :show, status: :created, location: @savedprogram }
        else
          flash[:notice]='Program is exists in your saved list. You can apply for this program from your saved list.'
          redirect_to programs_path
        end        
      else
        flash[:notice]='This program does not match your expertise.'
        redirect_to programs_path
      end
    rescue ActiveRecord::RecordNotUnique => e
      e.record.errors.details
      flash[:notice]='Something went wrong, please try after sometime.'
      redirect_to programs_path
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
      format.html { redirect_to "/trainers/profille", notice: 'Removed from your saved list.' }
      format.json { head :no_content }
    end
    #@savedprogram.destroy
    #respond_to do |format|
    #  if @savedprogram.update_attributes(:status=>'deleted')
    #    format.html { redirect_to "/trainers/profile", notice: 'Removed from your saved list.' }
    #    format.json { head :no_content }
    #  else
    #    format.json {render json: @savedprogram.errors, status: :unprocessable_entity}
    #    redirect_to "/trainers/profile"
    #  end
    #end
  end

  def savedlist
    respond_to do |format|
      if @savedprogram.update_attributes(:status=>'active')
        format.html { redirect_to "/trainers/profile", notice: 'Added to saved list.' }
        format.json { head :no_content }
      else
        format.json {render json: @savedprogram.errors, status: :unprocessable_entity}
        redirect_to "/trainers/profile"
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_savedprogram
      @savedprogram = Savedprogram.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def savedprogram_params
      params.require(:savedprogram).permit(:program_id, :trainer_id, :status)
    end
end

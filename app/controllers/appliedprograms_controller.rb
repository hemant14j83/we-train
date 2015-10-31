class AppliedprogramsController < ApplicationController
  before_action :set_appliedprogram, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_trainer!
  # GET /appliedprograms
  # GET /appliedprograms.json
  def index
    @appliedprograms = Appliedprogram.all
    @expiredappliedprograms = Appliedprogram.all
    @trainer=Trainer.find(current_trainer.id)
    @program=Program.find(:program_id)
  end

  # GET /appliedprograms/1
  # GET /appliedprograms/1.json
  def show
  end

  # GET /appliedprograms/new
  def new
    @appliedprogram = Appliedprogram.new
  end

  # GET /appliedprograms/1/edit
  def edit
  end

  # POST /appliedprograms
  # POST /appliedprograms.json
  def create
    @trainer=Trainer.find(current_trainer.id)
    @program=Program.find(params[:program_id])
    #@sdprogram=@trainer.appliedprograms.build(:program_id=>params[:program_id],:trainer_id=>params[:trainer_id])
    @appliedprogram = Appliedprogram.new(:status=>'forwardedtorecruiter',:program_id=>params[:program_id],:trainer_id=>current_trainer.id)
    begin
        if @appliedprogram.save
          flash[:notice]="Your application for #{@program.name} sent to recruiter." 
          Notifier.mailtotrainer(@appliedprogram,@program,@trainer).deliver_now
          Notifier.mailtorecruiter(@appliedprogram,@program,@trainer).deliver_now
          redirect_to programs_path
          #format.html { redirect_to "/programs", notice: 'Program Added to Saved List' }
          #format.json { render :show, status: :created, location: @savedprogram }
        else
          flash[:notice]='You have already applied for this program, please wait for recruiters response.'
          redirect_to programs_path
        end
    rescue ActiveRecord::RecordNotUnique => e
      e.record.errors.details
      flash[:notice]='Something went wrong, please try after sometime.'
      redirect_to programs_path
    end 
  end

  # PATCH/PUT /appliedprograms/1
  # PATCH/PUT /appliedprograms/1.json
  def update
  end

  # DELETE /appliedprograms/1
  # DELETE /appliedprograms/1.json
  def destroy
  end

  def savedlist
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_appliedprogram
      @appliedprogram = Aappliedprogram.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def savedprogram_params
      params.require(:appliedprogram).permit(:status,:program_id, :trainer_id, :status)
    end
end
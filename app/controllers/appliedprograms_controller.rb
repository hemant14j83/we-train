class AppliedprogramsController < ApplicationController
  before_action :set_appliedprogram, only: [:select,:show, :edit, :update, :destroy]
  before_filter :authenticate_trainer!,except: [:select,:reject]
  # GET /appliedprograms
  # GET /appliedprograms.json
  def index
    @appliedprograms = Appliedprogram.by_status('forwardedtorecruiter').recent
    #@expiredappliedprograms = Appliedprogram.all
    @trainer=Trainer.find(current_trainer.id)
    @program=Program.find(:program_id)
    #@recruiter=Recruiter.find_by_id(program.recruiter_id)
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
    @t_expertise=Expertise.find_by(trainer_id: current_trainer.id,expertise_in: @program.expertise)
    @sp=Savedprogram.find_by(program_id: params[:program_id])

    @recruiterid=@program.recruiter_id
    #@sdprogram=@trainer.appliedprograms.build(:program_id=>params[:program_id],:trainer_id=>params[:trainer_id])
    @appliedprogram = Appliedprogram.new(:status=>'forwardedtorecruiter',:program_id=>params[:program_id],:trainer_id=>current_trainer.id,:recruiter_id=>@recruiterid)
    begin
      if @t_expertise
        if @appliedprogram.save
          flash[:notice]="Your application for #{@program.name} sent to recruiter." 
          @sp.update_attributes(:status=>'done')
          Notifier.mailtotrainer(@appliedprogram,@program,@trainer).deliver_now
          Notifier.mailtorecruiter(@appliedprogram,@program,@recruiter).deliver_now
          redirect_to programs_path
          #format.html { redirect_to "/programs", notice: 'Program Added to Saved List' }
          #format.json { render :show, status: :created, location: @savedprogram }
        else
          flash[:notice]='You have already applied for this program, please wait for recruiters response.'
          redirect_to programs_path
        end
      else
        flash[:notice]="This program does not match your expertise. #{view_context.link_to('Edit Your Expertise','/trainers/profile#showexpert')}"
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

  def select
    respond_to do |format|      
      @appliedprogram = Appliedprogram.find_by_id(params[:id])
      @program=Program.find_by_id(@appliedprogram.program_id)
      #@recruiter=Recruiter.find_by_id(params[:recruiter_id])
      if @appliedprogram.update_attributes(:status=>'selected')
        format.html { redirect_to recruiter_root_path, notice: 'Congrats, you have selected your candidate successfully.' }
        Notifier.selectedmail(@appliedprogram,@program,@trainer,@recruiter).deliver_now
        @program.update_attributes(:status=>'done')
        format.json { render :show, status: :ok, location: @appliedprogram }
      else
        flash[:notice]='Something went wrong, please try again or contact us.'
      end
    end
  end
  
  def reject
    respond_to do |format|
      @appliedprogram = Appliedprogram.find_by_id(params[:id])
      if @appliedprogram.update_attributes(:status=>'rejected')
        format.html { redirect_to recruiter_root_path, notice: 'Rejected candidate.' }
        #Notifier.rejectedmail(@appliedprogram,@program,@trainer).deliver_now
        format.json { render :show, status: :ok, location: @appliedprogram }
      else
        flash[:notice]='Something went wrong, please try again or contact us.'
      end
    end
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
      @appliedprogram = Appliedprogram.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def appliedprogram_params
      params.require(:appliedprogram).permit(:status,:program_id, :trainer_id, :status, :recruiter_id)
    end
end
class ProgramsController < ApplicationController
	before_filter :authenticate_recruiter!, :except=>:index
  before_action :set_program, only: [:show, :edit, :update, :destroy]

 def new
  redirect_to '/recruiters/profile#programmodal'
 end

 def create
	@recruiter=Recruiter.find(current_recruiter.id)
	
	@program = @recruiter.programs.create(params[:program].permit(:name, :program_details, :duration, :duration_type, :payment_detail, :payment_type, :currency, :food_expense,:food_expense_conditions, :travel_expense,:travel_expense_conditions, :stay_expense, :stay_expense_conditions, :start_date, :end_date,:venue, :city, :state, :country, :expertise, :status, :category, :plan))
  if @program.save
    flash[:notice]='Program Added Successfully.'
    Notifier.newprogram(@program).deliver_now
    redirect_to recruiter_root_path
  else
    flash[:notice]='Something Went wrong, All fields are mandatory.'
    redirect_to recruiter_root_path
  end
  #if @program.save
  #  case @program.plan
  #  when "Featured"
  #    Notifier.newprogram_featured(@program).deliver_now
  #    flash[:notice]='Featured Program Added Successfully.'
  #    redirect_to recruiter_root_path
  #  when "Urgent"
  #    Notifier.newprogram_urgent(@program).deliver_now
  #    flash[:notice]='Urgent Program Added Successfully.'
  #    redirect_to recruiter_root_path
  #  when "Free"
  #    Notifier.newprogram(@program).deliver_now
  #    flash[:notice]='Program Added Successfully.'
  #    redirect_to recruiter_root_path
  #  else
  #    flash[:notice]='Failed, Getlost!!!'
  #    redirect_to recruiter_root_path
  #  end
  #end	
 end

 def index
 	@program = Program.all
  if @recruiter_signed_in
    @recruiter=Recruiter.find(current_recruiter.id)  
  end
 end

 def edit
 end

 def update
  @program=Program.find(params[:id])

    respond_to do |format|
      if @program.update(program_params)
        format.html { redirect_to recruiter_root_path, notice: 'Details updated successfully.' }
        format.json { render :show, status: :ok, location: @program }
      else
        format.html { render :edit }
        format.json { render json: @program.errors, status: :unprocessable_entity }
      end
    end
 end

 def approved

 end

 def destroy
  @program=Program.find(params[:id])
  begin
 	  respond_to do |format|
      if @program.update_attributes(:status=>'deleted')
        format.html { redirect_to recruiter_root_path, notice: 'Program Removed Successfully.' }
        format.json { head :no_content }        
      else
        format.json {render json: @program.errors, status: :unprocessable_entity}
        redirect_to recruiter_root_path, :flash => {:error => "Something Went Wrong"}
      end
    end
  rescue ActiveRecord::RecordNotFound => e
      redirect_to recruiter_root_path, :flash => {:error => "Something Went Wrong"}
  end
 end

 private
  def set_program
     @program = Program.find(params[:id])
  end
  def program_params
      params.require(:program).permit(:name, :program_details, :duration, :duration_type, :payment_detail, :payment_type, :currency, :food_expense,:food_expense_conditions, :travel_expense,:travel_expense_conditions, :stay_expense, :stay_expense_conditions, :start_date, :end_date,:venue, :city, :state, :country, :expertise, :category, :status, :plan)
  end
end

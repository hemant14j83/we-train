class ProgramsController < ApplicationController
	before_filter :authenticate_recruiter!

 def create
	@recruiter=Recruiter.find(current_recruiter.id)
	
	@program = @recruiter.programs.create(params[:program].permit(:name, :program_details, :duration, :duration_type, :payment_detail, :payment_type, :currency, :food_expense,:food_expense_conditions, :travel_expense,:travel_expense_conditions, :stay_expense, :stay_expense_conditions, :start_date, :end_date,:venue, :city, :state, :country, :expertise, :status, :category, :plan))
  flash[:notice]='Program Added Successfully.'
	redirect_to recruiter_root_path
	#redirect_to edit_recruiter_registration_path
 end

 def index
 	@program = Program.all
    @recruiter=Recruiter.find(current_recruiter.id)
 end

 def edit
  @program=Program.find(params[:id])
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
  begin
 	  @program = Program.find(params[:id])
    @program.destroy
    if @program.destroyed?
      redirect_to recruiter_root_path, :flash => {:success => "Program Removed Successfully."}
    else
      redirect_to recruiter_root_path, :flash => {:error => "Something Went Wrong"}
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

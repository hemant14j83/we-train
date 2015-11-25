class ProgramsController < ApplicationController
	before_filter :authenticate_recruiter!, :except=>:index
  before_action :set_program, only: [:show, :edit, :update, :destroy]

 def new
  redirect_to '/recruiters/profile#programmodal'
 end

 def create
	@recruiter=Recruiter.find(current_recruiter.id)
  @category=Category.find(params[:program][:category])
  params[:program][:category]=@category.name
	if params[:program][:travel_expense]==1
    params[:program][:travel_expense]="Yes"
  else
    params[:program][:travel_expense]="No"
  end
  if params[:program][:stay_expense]==1
    params[:program][:stay_expense]="Yes"
  else
    params[:program][:stay_expense]="No"
  end
  if params[:program][:food_expense]==1
    params[:program][:food_expense]="Yes"
  else
    params[:program][:food_expense]="No"
  end
	@program = @recruiter.programs.create(params[:program].permit(:name, :program_details, :duration, :duration_type, :payment_detail, :payment_type, :currency, :food_expense,:food_expense_conditions, :travel_expense,:travel_expense_conditions, :stay_expense, :stay_expense_conditions, :start_date, :end_date,:venue, :city, :state, :country, :expertise, :status, :category, :plan))
  if @program.save
    flash[:notice]='Program Added Successfully.'
    Notifier.newprogram(@program).deliver_now
    redirect_to "/recruiters/myaccount#showpostedprograms"
  else
    flash[:notice]='Something Went wrong.'
    redirect_to "/recruiters/myaccount#showpostedprograms"
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
 	@program = Program.paginate(:page=>params[:page],:per_page=>10).by_status('active').recent  
  if params[:search]
    @program = Program.paginate(:page=>params[:page],:per_page=>10).search(params[:search]).by_status('active').recent
  else
    @program = Program.paginate(:page=>params[:page],:per_page=>10).by_status('active').recent  
  end
  if @recruiter_signed_in
    @recruiter=Recruiter.find(current_recruiter.id)      
  end
 end

 def edit
  @program=Program.find(params[:id])
  @status=Appliedprogram.find_by(program_id: @program)
  render '404'
  #if @status=params[:id]
    #render partial: 'naprogram'
  #  flash[:notice]="Trainers have applied for this program, updation not allowed now."
  #  redirect_to "/recruiters/myaccount#showpostedprograms"
  #else
  #  render partial: 'program'
  #end
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

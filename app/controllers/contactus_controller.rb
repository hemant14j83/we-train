class ContactusController < ApplicationController
  before_action :set_contactu, only: [:show]#, :edit, :update, :destroy]

  # GET /contactus
  # GET /contactus.json
  def index
    @contactus = Contactu.all
    render 'shared/404'
  end

  # GET /contactus/1
  # GET /contactus/1.json
  def show
  end

  # GET /contactus/new
  def new
    @contactu = Contactu.new
  end

  # GET /contactus/1/edit
  def edit
    render 'shared/404'
  end

  # POST /contactus
  # POST /contactus.json
  def create
    @contactu = Contactu.new(contactu_params)

    respond_to do |format|
      if @contactu.save
        format.html { redirect_to "/contact-us", notice: 'Message submitted successfully.' }
        format.json { render :show, status: :created, location: @contactu }
        Notifier.newcontact(@contactu).deliver_now
        Notifier.newcontact_by(@contactu).deliver_now
      else
        format.html { redirect_to "/contact-us", notice: @contactu.errors.full_messages.to_sentence }
        #format.json { render json: @contactu.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contactus/1
  # PATCH/PUT /contactus/1.json
  def update
    respond_to do |format|
      if @contactu.update(contactu_params)
        format.html { redirect_to "/contact-us", notice: 'Contactu was successfully updated.' }
        format.json { render :show, status: :ok, location: @contactu }
      else
        format.html { redirect_to "/contact-us" }
        format.json { render json: @contactu.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contactus/1
  # DELETE /contactus/1.json
  def destroy
    @contactu.destroy
    respond_to do |format|
      format.html { redirect_to contactus_url, notice: 'Contactu was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contactu
      @contactu = Contactu.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contactu_params
      params.require(:contactu).permit(:name, :email, :organisation, :title, :department, :phone, :city, :contact_type,:subject, :message)
    end
end

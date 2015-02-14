class ConsentsController < ApplicationController
  before_action :set_consent, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    # All Consents for the logged in user
    @consents = current_user.consents
    respond_with(@consents)
  end

  def show
    # Status of the current Consent
    respond_with(@consent)
  end

  def new
    # New Consent for a Procedure
    @consent = Consent.new(user_id: current_user.id, procedure_id: params[:id])
    respond_with(@consent)
  end

  # def edit
  # end

  def create
    @consent = Consent.new(consent_params)
    @consent.save!
    redirect_to consent_indications_path(procedure_id: @consent.procedure_id, consent_id: @consent.id)
  end

  def create
    @consent = Consent.new(consent_params)
    @consent.save!
    redirect_to consent_indications_path(procedure_id: @consent.procedure_id, consent_id: @consent.id)
  end

  def indications
    @consent = Consent.find(params[:consent_id])
  end  

  def benefits
    @consent = Consent.find(params[:consent_id])
  end  

  def risks
    @consent = Consent.find(params[:consent_id])
  end  

  def alternatives
    @consent = Consent.find(params[:consent_id])
  end  

  def descriptions
    @consent = Consent.find(params[:consent_id])
  end  

  # def update
  #   @consent.update(consent_params)
  #   respond_with(@consent)
  # end

  def destroy
    # Cancel Consent
    @consent.destroy
    respond_with(@consent)
  end

  private
    def set_consent
      @consent = Consent.find(params[:id])
    end

    def consent_params
      params.require(:consent).permit(:user_id, :procedure_id, :indications_complete, :benefits_complete, :risks_complete, :alternatives_complete, :description_complete, :consent_complete)
    end
end

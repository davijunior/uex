class ContactsController < ApplicationController
  before_action :authorize
  before_action :set_contact, only: %i[ show update destroy ]

  # GET /contacts
  def index
    @contacts = Contact.joins(:address).map do |contact|
      contact.attributes.merge(address: contact.address.attributes)
    end
    render json: @contacts
  end

  # GET /contacts/1
  def show
    render json: @contact.includes(:address)
  end

  # POST /contacts
  def create
    @contact = Contact.new(contact_params)
    @address = Address.new(address_params)
    if @contact.save
      @address.contact = @contact
      @address.save!
      render json: {data: @contact, success: true}, status: :created, location: @contact
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /contacts/1
  def update
    if @contact.update(contact_params)
      render json: @contact
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  # DELETE /contacts/1
  def destroy
    @contact.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def contact_params
      params.require(:contact).permit(:name, :phone, :email, :cpf)
    end

    def address_params
      params.require(:address).permit(:street, :city, :state, :zip_code, :number, :latitude, :longitude, :neighborhood)
    end
end

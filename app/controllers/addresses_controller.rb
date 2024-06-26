class AddressesController < ApplicationController
  before_action :authorize
  before_action :set_address, only: %i[ show update destroy ]

  # GET /addresses
  def index
    @addresses = Address.all

    render json: @addresses
  end

  def check_address_by_cep
    cep = params[:cep]
    service = ::CepService.new(cep)
    address = service.get_address

    render json: address
  end

  # GET /addresses/1
  def show
    render json: @address
  end

  # POST /addresses
  def create
    @address = Address.new(address_params)

    if @address.save
      render json: @address, status: :created, location: @address
    else
      render json: @address.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /addresses/1
  def update
    if @address.update(address_params)
      render json: @address
    else
      render json: @address.errors, status: :unprocessable_entity
    end
  end

  # DELETE /addresses/1
  def destroy
    @address.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_address
      @address = Address.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def address_params
      params.require(:address).permit(:street, :number, :complement, :neighborhood, :city, :state, :zip_code, :contact_id)
    end
end

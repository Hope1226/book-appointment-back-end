class ReservationsController < ApplicationController
  before_action :authenticate_user! #-> routes to the login / signup if not authenticated
  before_action :set_reservation, only: %i[show update destroy]

  # GET /reservations
  def index
    @reservations = current_user.reservations.includes(:space)
    @reservations_spaces = @reservations.map do |record|
      record.attributes.merge(
        'space' => record.space
      )
    end
    render json: @reservations_spaces
  end

  # GET /reservations/1
  def show
    render json: @reservation
  end

  # POST /reservations
  def create
    @reservation = current_user.reservations.create

    if @reservation.save
      render json: @reservation, status: :created, location: @reservation
    else
      render json: @reservation.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /reservations/1
  def update
    if @reservation.update(reservation_params)
      render json: @reservation
    else
      render json: @reservation.errors, status: :unprocessable_entity
    end
  end

  # DELETE /reservations/1
  def destroy
    @reservation.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def reservation_params
    params.require(:reservation).permit(:city, :date, :space_id, :user_id)
  end
end

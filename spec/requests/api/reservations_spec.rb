# rubocop:disable Metrics/BlockLength

require 'swagger_helper'

RSpec.describe 'Reservations api', type: :request do
  path '/reservations' do
    get 'Retrieves all reservations' do
      tags 'Reservations'
      produces 'application/json'
      security [{ Bearer: [] }]

      response '200', 'reservations retrieved' do
        let(:reservation) { Reservation.all }
        run_test!
      end

      response '404', 'reservations not found' do
        run_test!
      end
    end

    post 'Creates a new reservation' do
      tags 'Reservations'
      consumes 'application/json'
      security [{ Bearer: [] }]
      parameter name: :reservation, in: :body, schema: {
        type: :object,
        properties: {
          space_id: { type: :string },
          city: { type: :string },
          date: { type: :string }
        }
      }

      response '201', 'reservation created' do
        let(:reservation) { { space_id: 1, city: 'test city', date: 'test date' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:reservation) { { city: 'test city' } }
        run_test!
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength

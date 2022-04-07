require 'swagger_helper'

RSpec.describe 'Session Api', type: :request do
  path '/signup' do
    post 'Creates a new user' do
      tags 'Session'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        user: {
          type: :object,
          properties: {
            name: { type: :string },
            email: { type: :string },
            password: { type: :string },
            password_confirmation: { type: :string },
          }
        },
        required: [ 'name', 'email', 'password', 'password_confirmation' ]
      }

      response '201', 'user created' do
        let(:user) { { name: 'test name', email: 'email@gmail.com', password: 'password', password_confirmation: 'password' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:user) { { email: 'email@gmail.com' } }
        run_test!
      end
    end
  end
end

require 'swagger_helper'

RSpec.describe 'Signup Api', type: :request do
  path '/signup' do
    post 'Creates a new user' do
      tags 'Sign up'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        user: {
          type: :object,
          properties: {
            name: { type: :string },
            email: { type: :string },
            password: { type: :string },
            password_confirmation: { type: :string }
          }
        },
        required: %w[name email password password_confirmation]
      }

      response '201', 'Signed up successfull' do
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

RSpec.describe 'Login Api', type: :request do
  path '/login' do
    post 'Creates a new user' do
      tags 'Login'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        user: {
          type: :object,
          properties: {
            email: { type: :string },
            password: { type: :string }
          }
        },
        required: %w[email password]
      }

      response '201', 'Logged in successfull' do
        let(:user) { { email: 'email@gmail.com', password: 'password' } }
        run_test!
      end

      response '422', 'invalid request' do
        run_test!
      end
    end
  end
end

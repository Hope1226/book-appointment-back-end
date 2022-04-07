# rubocop:disable Metrics/BlockLength
require 'swagger_helper'

RSpec.describe 'Spaces Api', type: :request do
  path '/spaces' do
    post 'Creates a new space' do
      tags 'Spaces'
      consumes 'application/json'
      security [{ Bearer: [] }]
      parameter name: :space, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          description: { type: :string },
          image: { type: :string },
          price: { type: :number }
        },
        required: %w[name description image price]
      }

      response '201', 'space created' do
        let(:space) { { name: 'test name', description: 'test description', image: 'test image', price: 1 } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:space) { { name: 'test name' } }
        run_test!
      end
    end

    get 'Retrieves all spaces' do
      tags 'Spaces'
      produces 'application/json'
      security [{ Bearer: [] }]

      response '200', 'spaces retrieved' do
        let(:space) { Space.all }
        run_test!
      end

      response '404', 'spaces not found' do
        run_test!
      end
    end
  end
end

RSpec.describe 'Space Api', type: :request do
  path '/spaces/{id}' do
    get 'Retrieves a space' do
      tags 'Spaces'
      produces 'application/json'
      security [{ Bearer: [] }]
      parameter name: :id, in: :path, type: :string

      response '200', 'space retrieved' do
        let(:space) { Space.first }
        run_test!
      end

      response '404', 'space not found' do
        run_test!
      end
    end

    delete 'Deletes a space' do
      tags 'Spaces'
      consumes 'application/json'
      security [{ Bearer: [] }]
      parameter name: :id, in: :path, type: :string

      response '200', 'space deleted' do
        let(:space) { Space.destroy(Space.first.id) }
        run_test!
      end

      response '404', 'space not found' do
        run_test!
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength

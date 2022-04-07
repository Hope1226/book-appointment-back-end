require 'swagger_helper'

RSpec.describe 'Spaces Api', type: :request do
  path '/spaces' do

    post 'Creates a new space' do
      tags 'Spaces'	
      consumes 'application/json'
      parameter name: :space, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          description: { type: :string },
          image: { type: :string },
          price: { type: :number },
        },
        required: [ 'name', 'description', 'image', 'price' ]
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

      response '200', 'spaces retrieved' do
        schema type: :array,
          items: {
            type: :object,
            properties: {
              id: { type: :integer },
              name: { type: :string },
              description: { type: :string },
              image: { type: :string },
              price: { type: :number },
            },
            required: [ 'id', 'name', 'description', 'image', 'price' ]
          }
        run_test!
      end

      response '404', 'spaces not found' do
        run_test!
      end
    end

    get 'Retrieves a space' do
      tags 'Spaces'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      response '200', 'space found' do
        schema type: :object,
          properties: {
            id: { type: :integer },
            name: { type: :string },
            description: { type: :string },
            image: { type: :string },
            price: { type: :number },
          },
          required: [ 'id', 'name', 'description', 'image', 'price' ]

        let(:id) { Space.create(name: 'test name', description: 'test description', image: 'test image', price: 1).id }
        run_test!
      end

      response '404', 'space not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end

    delete 'Deletes a space' do
      tags 'Spaces'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      response '204', 'space deleted' do
        let(:id) { Space.create(name: 'test name', description: 'test description', image: 'test image', price: 1).id }
        run_test!
      end

      response '404', 'space not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end

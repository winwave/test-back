require 'swagger_helper'

describe 'Pets API' do

  path '/api/v1/users' do

    post 'Creates a user' do
      tags 'Users'
      consumes 'application/json'
      parameter name: :pet, in: :body, schema: {
          type: :object,
          properties: {
              pseudo: { type: :string }
          },
          required: [ 'pseudo' ]
      }

      response '201', 'user created' do
        let(:user) { { pseudo: 'ABC' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:user) { { name: 'abc' } }
        run_test!
      end
    end
  end

  path '/api/v1/users' do

    get 'Retrieves all users' do
      tags 'Users'
      produces 'application/json'

      response '200', 'users' do
        schema type: :object,
               properties: {
                   id: { type: :integer, },
                   pseudo: { type: :string, },
                   decimal_index: { type: :decimal },
                   created_at: { type: :string },
                   updated_at: { type: :string },
               },
               required: %w[pseudo decimal_index]

        let(:user) { User.create(pseudo: 'AAA', decimal_index: '703') }
        run_test!
      end
    end
  end
end

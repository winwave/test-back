# frozen_string_literal: true

require 'swagger_helper'

describe 'Users API' do
  path '/api/v1/users' do
    post 'Creates a user' do
      tags 'Users'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          pseudo: { type: :string }
        },
        required: ['pseudo']
      }

      response '201', 'user created' do
        schema type: :object,
               properties: {
                 message: { type: :string }
               }
        let(:user) { { pseudo: 'ABC' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:user) { { pseudo: 'abc' } }
        run_test!
      end
    end
  end

  path '/api/v1/users' do
    get 'Retrieves all users' do
      tags 'Users'
      produces 'application/json'

      response '200', 'list users' do
        schema type: :array,
               properties: {
                 type: :object,
                 properties: {
                   id: { type: :integer, },
                   pseudo: { type: :string, },
                   decimal_index: { type: :decimal },
                   created_at: { type: :string },
                   updated_at: { type: :string },
                 },
                 required: %w[pseudo decimal_index]
               }

        let(:user) { User.create(pseudo: 'AAA', decimal_index: '703') }
        run_test!
      end
    end
  end
end

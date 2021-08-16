require 'rails_helper'

RSpec.describe Api::V1::MyPoolsController, type: :request do
  describe 'GET /pools' do
    before :each do
      FactoryBot.create_list(:my_pool, 10)
      get '/api/v1/pools'
    end

    it { expect(response).to have_http_status(200) }

    it 'manda la lista de encuestas' do
      json = JSON.parse(response.body)
      #puts(json)
      expect(json["data"].length).to eq(MyPool.count)
    end
  end

  describe 'GET /pools/:id' do
    before :each do
      @pool = FactoryBot.create(:my_pool)
      get "/api/v1/pools/#{@pool.id}"
    end

    it { expect(response).to have_http_status(200) }

    it 'manda la encuesta solicitada' do
      json = JSON.parse(response.body)
      expect(json["data"]['id']).to eq(@pool.id)
    end

    it 'manda los atributos de la encuesta' do
      json = JSON.parse(response.body)
      expect(json["data"].keys).to contain_exactly('id', 'title', 'description', 'expires_at', 'user_id')
    end
  end

  describe 'POST /pools' do
    context 'con token valido' do
      before :each do
        @token = FactoryBot.create(:token, expires_at: DateTime.now + 10.minutes)
        post '/api/v1/pools/',
             { params: { token: @token.token,
                         pool: { title: 'Hola mundo', description: 'asdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasd',
                                 expires_at: DateTime.now } } }
      end

      it { expect(response).to have_http_status(200) }

      it 'crea una nueva encuesta' do
        expect do
          post '/api/v1/pools/',
               { params: { token: @token.token,
                           pool: { title: 'Hola mundo', description: 'asdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasd',
                                   expires_at: DateTime.now } } }
        end.to change(MyPool, :count).by(1)
      end
      it 'responde con la encuesta creada' do
        json = JSON.parse(response.body)
        puts "\n\n\n --#{json}-- \n\n\n"
        expect(json["data"]['title']).to eq('Hola mundo')
      end
    end

    context 'con token invalido' do
      before :each do
        post '/api/v1/pools/'
      end

      it { puts response.body ; expect(response).to have_http_status(401) }
    end

    context 'invalid params' do
      before :each do
        @token = FactoryBot.create(:token, expires_at: DateTime.now + 10.minutes)
        post '/api/v1/pools/',
             { params: { token: @token.token, pool: { title: 'Hola mundo', expires_at: DateTime.now } } }
      end

      it { expect(response).to have_http_status(422) }

      it 'responde con los errores al guardar la respuesta' do
        puts response.body
        json = JSON.parse(response.body)
        expect(json['errors']).to_not be_empty
      end
    end
  end

  describe 'PATCH /pools/:id' do
    context 'con token valido' do
      before :each do
        @token = FactoryBot.create(:token, expires_at: DateTime.now + 10.minutes)
        @pool = FactoryBot.create(:my_pool, user: @token.user)
        patch api_v1_pool_path(@pool, { params: { token: @token.token, pool: { title: 'Nuevo titulo' } } })
      end
      it { expect(response).to have_http_status(200) }

      it 'actualizar la encuesta indicada' do
        json = JSON.parse(response.body)
        expect(json["data"]['title']).to eq('Nuevo titulo')
      end
    end

    context 'con token invalido' do
      before :each do
        @token = FactoryBot.create(:token, expires_at: DateTime.now + 10.minutes)
        @pool = FactoryBot.create(:my_pool, user: FactoryBot.create(:dummy_user))
        patch api_v1_pool_path(@pool, { params: { token: @token.token, pool: { title: 'Nuevo titulo' } } })
      end

      it { expect(response).to have_http_status(401) }
    end
  end

  describe "DELETE /pools/:id" do
    context 'con token valido' do
      before :each do
        @token = FactoryBot.create(:token, expires_at: DateTime.now + 10.minutes)
        @pool = FactoryBot.create(:my_pool, user: @token.user)
      end

      it { 
        delete api_v1_pool_path(@pool) ,{ params: {token: @token.token} }
        expect(response).to have_http_status(200) 
      }

      it 'elimina la encuesta indicada' do
       expect{
         delete api_v1_pool_path(@pool) ,{ params: {token: @token.token} }
       }.to change(MyPool, :count).by(-1)
      end
    end

    context 'con token invalido' do
      before :each do
        @token = FactoryBot.create(:token, expires_at: DateTime.now + 10.minutes)
        @pool = FactoryBot.create(:my_pool, user: FactoryBot.create(:dummy_user))
        delete api_v1_pool_path(@pool, { params: { token: @token.token } })
      end

      it { expect(response).to have_http_status(401) }
    end
  end
end

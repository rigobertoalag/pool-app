require 'rails_helper'

RSpec.describe Api::V1::QuestionsController, type: :request do
  before :each do
    @token = FactoryBot.create(:token, expires_at: DateTime.now + 1.month)
    @pool = FactoryBot.create(:pool_with_questions, user: @token.user)
  end

  describe 'GET /pools/:pool_id/questions' do
    before :each do
      get "/api/v1/pools/#{@pool.id}/questions"
    end

    it { expect(response).to have_http_status(200) }

    it 'mande la lista de preguntas para la encuesta' do
      json = JSON.parse(response.body)
      expect(json.length).to eq(@pool.questions.count)
    end

    it 'manda la descripcion y el id de una pregunta' do
      json_array = JSON.parse(response.body)
      #puts("\n\n -- #{json_array} -- \n\n")
      question = json_array["data"][0]
      expect(question["attributes"].keys).to contain_exactly('id', 'description', 'created_at', 'updated_at', 'my_pool_id')
    end
  end

  describe "GET /pools/:pool_id/questions/:id" do 
    before :each do 
      @question = @pool.questions[0]

      get api_v1_pool_question_path(@pool, @question), {params: { question:{ description: "Hola mundo" } }}
    end

    it {  expect(response).to have_http_status(200) }

    it "esperamos que nos mande la pregunta solicitada" do 
      json = JSON.parse(response.body)
      expect(json["data"]["attributes"]["description"]).to eq(@question.description)
    end
  end
  
  describe 'POST /pools/:pool_id/questions' do

    context "con usuario valido" do
      before :each do 
        post api_v1_pool_questions_path(@pool), { params: { question: { description: "Cual es tu lengiaje fvorito" }, token: @token.token } }
      end

      it { expect(response).to have_http_status(200) }

      it "cambia el numero de preguntas +1" do 
        expect{
          post api_v1_pool_questions_path(@pool), { params: { question: { description: "Cual es tu lengiaje fvorito" }, token: @token.token } }
        }.to change(Question,:count).by(1)
      end

      it "responde con la pregunta creada" do
        json = JSON.parse(response.body)
        expect(json["data"]["attributes"]["description"]).to eq("Cual es tu lengiaje fvorito")
      end
    end

    context "con usuario invalido" do
      before :each do 
        new_user = FactoryBot.create(:dummy_user)
        @new_token = FactoryBot.create(:token, user: new_user, expires_at: DateTime.now + 1.month)
        post api_v1_pool_questions_path(@pool), { params: { question: { description: "Cual es tu lengiaje fvorito" }, token: @new_token.token } }
      end

      it { expect(response).to have_http_status(401) }

      it "cambia el numero de preguntas a 0" do 
        expect{
          post api_v1_pool_questions_path(@pool), { params: { question: { description: "Cual es tu lengiaje fvorito" }, token: @new_token.token } }
        }.to change(Question,:count).by(0)
      end
    end
  end

  describe "PUT /pools/:pool_id/questions/:id" do
    before :each do
      @question = @pool.questions[0]

      patch api_v1_pool_question_path(@pool, @question), {params: { question: { description: "Hola mundo" }, token: @token.token }}
    end
    
    it { expect(response).to have_http_status(200) }

    it "actualiza los datos indicados" do 
      json = JSON.parse(response.body)
      expect(json["data"]["attributes"]["description"]).to eq("Hola mundo")
    end

  end

  describe "DELETE /pools/:pool_id/questions/:id" do
    before :each do
      @question = @pool.questions[0]
    end

    it "elimina con status 200" do 
      delete api_v1_pool_question_path(@pool, @question), { params: { token: @token.token}}
      expect(response).to have_http_status(200)
    end 

    it "Elimina la prueba" do
      delete api_v1_pool_question_path(@pool, @question), { params: { token: @token.token}}
      expect(Question.where(id: @question.id)).to be_empty
    end

    it "reduce el conteo de preguntas a -1" do 
      expect {
        delete api_v1_pool_question_path(@pool, @question), { params: { token: @token.token}}
      }.to change(Question, :count).by(-1)
    end
  end
end
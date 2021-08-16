require 'rails_helper'

RSpec.describe Api::V1::AnswersController, type: :request do
  before :each do
    @token = FactoryBot.create(:token, expires_at: DateTime.now + 1.month)
    @pool = FactoryBot.create(:pool_with_questions, user: @token.user)
    @question = @pool.questions[0]
  end

  let(:valid_params) { { description: 'Ruby', question_id: @question.id } }

  describe 'POST /pools/:pool_id/questions/answers' do
    context 'con usuario valido' do
      before :each do
        post api_v1_pool_answers_path(@pool),
             { params: { answer: valid_params, token: @token.token } }
      end

      it { expect(response).to have_http_status(200) }

      it 'cambia el contador de respuestas a +1' do
        expect do
          post api_v1_pool_answers_path(@pool),
               { params: { answer: valid_params, token: @token.token } }
        end.to change(Answer, :count).by(1)
      end

      it 'responde con la respuesta creada' do
        json = JSON.parse(response.body)
        puts(json)
        expect(json['description']).to eq(valid_params[:description])
      end
    end
  end

  describe 'PUT /pools/:pool_id/questions/:id' do
    before :each do 
      @answer = FactoryBot.create(:answer, question: @question)
      put api_v1_pool_answer_path(@pool, @answer), { params: { answer: { description: "Nueva respuesta" }, token: @token.token } }
    end

    it {expect(response).to have_http_status(200) }

    it "actualiza los campos indicados" do 
      @answer.reload
      expect(@answer.description).to eq("Nueva respuesta")
    end
  end

  describe 'DELETE /pools/:pool_id/questions/:id' do
    before :each do 
      @answer = FactoryBot.create(:answer, question: @question)
    end

    it "responde con estatus de 200" do 
      delete api_v1_pool_answer_path(@pool, @answer), { params: {token: @token.token } }
      expect(response).to have_http_status(200)
    end

    it "cambia el contador de answer en -1" do 
      expect{
        delete api_v1_pool_answer_path(@pool, @answer), { params: {token: @token.token } }
      }.to change(Answer, :count).by(-1)
    end

    it "" do 
      expect{
        
      }
    end
  end
end

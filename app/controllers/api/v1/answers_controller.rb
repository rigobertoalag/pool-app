class Api::V1::AnswersController < Api::V1::MasterApiController
  before_action :authenticate, except: %i[index show]
  before_action :set_answer, only: %i[update destroy]
  before_action :set_pool
  before_action(only: %i[update destroy create]) { |controlador| controlador.authenticate_owner(@pool.user) }

  def create
    @answer = Answer.new(answer_params)

    if @answer.save
      render template: 'api/v1/answers/show'
    else
      render json: { error: @answer.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @answer.update(answer_params)
      render template: 'api/v1/answers/show'
    else
      render json: { error: @answer.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @answer.destroy
    head :ok
  end

  private

  def set_pool
    @pool = MyPool.find(params[:pool_id])
  end

  def answer_params
    params.require(:answer).permit(:description, :question_id)
  end

  def set_answer
    @answer = Answer.find(params[:id])
  end
end

class Api::V1::QuestionsController < Api::V1::MasterApiController 
  before_action :authenticate, except: %i[index show]
  before_action :set_question, only: %i[show update destroy]
  before_action :set_pool
  before_action(only: [:update, :destroy, :create]) { |controlador| controlador.authenticate_owner(@pool.user) }

  def index
    @questions = @pool.questions
  end

  def show
    
  end

  def create
    @question = @pool.questions.new(question_params)
    
    if @question.save
        render template: "api/v1/questions/show"
    else
        render json: { error: @question.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @question.update(question_params)
      render template: "api/v1/questions/show"
    else
      render json: { error: @question.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @question.destroy 
    head :ok
  end

  private

  def set_pool
    @pool = MyPool.find(params[:pool_id])
  end

  def question_params
    params.require(:question).permit(:description)
  end

  def set_question
    @question = Question.find(params[:id])
  end
end
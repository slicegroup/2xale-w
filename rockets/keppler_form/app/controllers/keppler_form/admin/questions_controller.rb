require_dependency 'keppler_form/application_controller'
module KepplerForm
  module Admin
    # QuestionsController
    class QuestionsController < ::Admin::AdminController
      layout 'keppler_form/admin/layouts/application'
      skip_before_action :verify_authenticity_token
      before_action :authenticate_user!
      before_action :set_poll
      before_action :set_question, except: %i[create]
      include ObjectQuery

      def create
        @question_type = params[:question_type]
        @questions = Question.where(poll_id: @poll.id)
        @question = Question.create(
          sentence: '',
          description: '',
          ask_type: @question_type,
          position: Question.count + 1,
          poll_id: @poll.id
        )
      end

      def delete
        @question_type = params[:question_type]
        @questions = Question.where(poll_id: @poll.id)
        @question.results_questions.destroy
        @question.destroy
      end

      def edit; end

      def update
        @question.update(question_params)
      end

      def add_option
        Option.create name: params[:name], question_id: @question.id
      end

      def delete_option
        @option = Option.find(params[:option_id])
        @option.destroy
      end

      private

      def set_question
        @question = Question.find(params[:id])
      end

      def set_poll
        @poll = Poll.find(params[:poll_id])
      end

      def question_params
        params.require(:question).permit(:sentence, :description)
      end
    end
  end
end

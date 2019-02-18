# frozen_string_literal: true

require_dependency 'keppler_form/application_controller'
module KepplerForm
  module Admin
    # PollsController
    class PollsController < ::Admin::AdminController
      layout 'keppler_form/admin/layouts/application'
      skip_before_action :verify_authenticity_token
      before_action :authenticate_user!
      before_action :set_poll, only: %i[show edit update destroy]
      before_action :set_poll_in_statistics, only: %i[poll_statistics]
      before_action :set_languages, only: %i[new edit]
      before_action :index_variables
      include ObjectQuery

      # GET <%= route_url %>
      def index
        respond_to_formats(@polls)
        redirect_to_index(@objects)
      end

      def toggle
        @poll = Poll.find(params[:poll_id])
        @polls = Poll.all

        @polls.update_all(active: false)
        @poll.update(active: params[:poll][:active])

        redirect_to admin_poll_polls_path
      end

      # GET <%= route_url %>/1
      def show
        @questions = Question.where(poll_id: @poll.id).order(id: :asc)
        @question_types =
          {
            short_text: 'font',
            long_text: 'paragraph',
            yes_or_not: 'toggle-off',
            simple_selection: 'dot-circle',
            multiple_selection: 'check-square'
          }
      end

      # GET <%= route_url %>/new
      def new
        @poll = Poll.new
      end

      # GET <%= route_url %>/1/edit
      def edit; end

      # POST <%= route_url %>
      def create
        @poll = Poll.new(poll_params)

        if @poll.save!
          redirect(@poll, params)
        else
          render :new
        end
      end

      # PATCH/PUT <%= route_url %>/1
      def update
        if @poll.update(poll_params)
          redirect(@poll, params)
        else
          render :edit
        end
      end

      def clone
        @poll = Poll.clone_record params[:poll_id]
        @poll.save
        redirect_to_index(@objects)
      end

      # DELETE <%= route_url %>/1
      def destroy
        @poll.destroy
        redirect_to_index(@objects)
      end

      def destroy_multiple
        Poll.destroy redefine_ids(params[:multiple_ids])
        redirect_to_index(@objects)
      end

      def upload
        Poll.upload(params[:file])
        redirect_to_index(@objects)
      end

      def reload; end

      def sort
        Poll.sorter(params[:row])
      end

      def poll_statistics
        @questions = Question.where(poll_id: @poll.id)
        @count = Result.count
      end

      private

      def index_variables
        @q = Poll.ransack(params[:q])
        @polls = @q.result(distinct: true)
        @objects = @polls.page(@current_page).order(position: :desc)
        @total = @polls.size
        @attributes = Poll.index_attributes
      end

      # Use callbacks to share common setup or constraints between actions.
      def set_poll
        @poll = Poll.find(params[:id])
      end

      def set_poll_in_statistics
        @poll = Poll.find(params[:poll_id])
      end

      def set_languages
        @languages = [
          ['Español', 'ES'],
          ['English', 'EN']
        ]
      end

      # Only allow a trusted parameter "white list" through.
      def poll_params
        params.require(:poll).permit(
          :name, :language, :public, :position, :deleted_at
        )
      end
    end
  end
end

require_dependency 'keppler_form/application_controller'
module KepplerForm
  module Admin
    # ResultsController
    class ResultsController < ::Admin::AdminController
      layout 'keppler_form/admin/layouts/application'
      skip_before_action :verify_authenticity_token
      before_action :authenticate_user!
      before_action :set_result, only: %i[show edit update destroy]
      before_action :set_poll
      before_action :index_variables
      include ObjectQuery

      # GET <%= route_url %>
      def index
        respond_to_formats(@results)
        redirect_to_index(@objects)
      end

      def toggle
        @result = Result.find(params[:result_id])
        @results = Result.all

        @results.update_all(active: false)
        @result.update(active: params[:result][:active])

        redirect_to :index
      end

      # GET <%= route_url %>/1
      def show
        @questions = Question.where(result_id: @result.id)
      end

      # GET <%= route_url %>/new
      def new
        @result = Result.new
      end

      # GET <%= route_url %>/1/edit
      def edit; end

      # POST <%= route_url %>
      def create
        @result = Result.new(result_params)

        if @result.save!
          redirect(@result, params)
        else
          render :new
        end
      end

      # PATCH/PUT <%= route_url %>/1
      def update
        if @result.update(result_params)
          redirect(@result, params)
        else
          render :edit
        end
      end

      def clone
        @result = Result.clone_record params[:result_id]
        @result.save
        redirect_to_index(@objects)
      end

      # DELETE <%= route_url %>/1
      def destroy
        @result.destroy
        redirect_to_index(@objects)
      end

      def destroy_multiple
        Result.destroy redefine_ids(params[:multiple_ids])
        redirect_to_index(@objects)
      end

      def upload
        Result.upload(params[:file])
        redirect_to_index(@objects)
      end

      def reload; end

      def sort
        Result.sorter(params[:row])
      end

      def result_statistics
        @questions = Question.where(result_id: @result.id)
        @count = Result.count
      end

      private

      def index_variables
        @q = Result.ransack(params[:q])
        @results = @q.result(distinct: true)
        @objects = @results.page(@current_page).order(position: :desc)
        @total = @results.size
        @attributes = Result.index_attributes
      end

      # Use callbacks to share common setup or constraints between actions.
      def set_result
        @result = Result.find(params[:id])
      end

      def set_poll
        @poll = Poll.find(params[:poll_id])
      end

      # Only allow a trusted parameter "white list" through.
      def result_params
        params.require(:result).permit(
          :name, :email, :phone, :email, :result_id, :position, :deleted_at
        )
      end
    end
  end
end

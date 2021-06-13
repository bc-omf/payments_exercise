class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

  private

  def not_found
    render json: 'not_found', status: :not_found
  end

  def record_invalid(exception)
    render json: exception, status: :unprocessable_entity
  end
end

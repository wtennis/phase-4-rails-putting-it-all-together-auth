class ApplicationController < ActionController::API
  include ActionController::Cookies
  wrap_parameters format: []
  rescue_from ActiveRecord::RecordInvalid, with: :invalid_record_response


private

def invalid_record_response(exception)
  render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity 
end

def authorize
  return render json: { errors: ["Not authorized"] }, status: :unauthorized unless session.include? :user_id
end

end

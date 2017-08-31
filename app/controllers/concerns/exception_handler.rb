module ExceptionHandler 
    extend ActiveSupport::Concern 

    included do  
        rescue_from ActiveRecord::RecordNotFound do |entity| 
            render json: { message: entity.message }, status: :not_found
        end 

        rescue_from ActiveRecord::RecordInvalid, ActionController::ParameterMissing do |entity| 
            render json: { message: entity.message }, status: :unprocessable_entity
        end
    end 
end


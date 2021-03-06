module ApplicationHelper
 
def errors_for(model, attribute)
  if model.errors[attribute].present?
    content_tag :span, :class => 'error_explanation' do
      model.errors[attribute].join(", ")
    end
  end
end

def current_user
	session[:member].present? ? session[:member] : false 
end

def is_a_social_member?
  if current_user
  	if current_user["social_accounts"].presence && current_user["social_accounts"].first["id"] != nil
  		true
  	else
  		false
  	end	
  else
  	false
  end	
end	
	
end

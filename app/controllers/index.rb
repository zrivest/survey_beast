enable :sessions
require 'pry'

get '/' do
  # session.clear
  erb :index
end

post '/log_in' do
  @user = User.find_by_email(params[:email])

  # binding.pry
  if @user && @user.authenticate(params[:password])
    session[:user_id] = @user.id
    
    erb :survey_list
  else
    redirect to '/'
  end 
end

post '/sign_up' do
  user = User.new(params[:user])
  user.password = params[:password]

  if user.save
    session[:user_id] = user.id
    redirect to '/survey_list'
  else
    redirect to '/'
  end
end

get '/survey_list' do
  erb :survey_list 
end

# post '/creat_new_survey'
#   #this button will redirect to the create_new_survey_page 
# end


# get '/create_new_survey' do 
#   erb :create_new_survey
# end

# post '/add_question' do
#   #redirect to create_new_survey page to add another question. 
# end

# post '/finish_survey' do
#   #redirect to the survey_list 
# end

# get '/take_survey' do 
#   erb take_survey
# end


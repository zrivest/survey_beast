get '/' do
  # Look in app/views/index.erb
  erb :index
end

post '/login' do
  # if success redirect to '/survey_list' 
  # else redirect to '/'' 
end

# post '/sign_up' do
#   # if success redirect to '/survey_list' 
#   # else redirect to '/''
# end

# get '/survey_list' do
#   erb :survey_list 
# end

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


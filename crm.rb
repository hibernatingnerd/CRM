require_relative 'contact'
require 'sinatra'

get '/index' do
  erb :index

end

get '/about' do
  erb :about
end

# get '/contacts' do
#   @contacts = Contact.all
#   erb :contacts
# end

get '/contacts/:id' do
  @contact = Contact.find_by(id: params[:id].to_i)
  if @contact
    erb :show_contact
  else
    raise Sinatra::NotFound
  end
end

# post '/new' do
#   user_first_name =  params[:firstname]
#   user_last_name = params[:lastname]
#   user_email = params[:email]
#   user_note = params[:notes]
#
#   Contact.create(firstname: user_first_name,
#     lastname: user_last_name,
#     email: user_email,
#     note: user_note)
#
#   # always redirect to ("/") on anything but a GET. On a GET use erb :file
# end
get '/' do
  @contacts = Contact.all
  @num_contacts = @contacts.count
  erb :contacts
end

get '/contacts' do
  redirect to '/'
end

get '/contacts/new' do
  erb :new
end

post '/contacts' do
  Contact.create(
    first_name: params[:first_name],
    last_name:  params[:last_name],
    email:      params[:email],
    note:       params[:note]
  )
  redirect to('/contacts')
end


after do
  ActiveRecord::Base.connection.close
end

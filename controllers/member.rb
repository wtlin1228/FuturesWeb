# frozen_string_literal: true

# Futures web application
class FuturesWeb < Sinatra::Base
  # Home page: show list of all groups
  get '/?' do
    result = GetAllMembers.call
    if result.success?
      @data = result.value
    else
      flash[:error] = result.value.message
    end

    slim :member
  end

  # Add a new Facebook group to our systems
  post '/member/?' do
    result = CreateNewMember.call(params)

    if result.success?
      flash[:notice] = 'Member successfully added'
    else
      flash[:error] = result.value.message
    end

    redirect '/'
  end

  get '/member/:phone/?' do
    # TODO: get postings and information from a single group
  end
end

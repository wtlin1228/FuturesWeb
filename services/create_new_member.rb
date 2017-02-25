# frozen_string_literal: true

# Create a new member from API
class CreateNewMember
  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin

  def self.call(params)
    Dry.Transaction(container: self) do
      step :call_api_to_create_member
    end.call(params)
  end

  register :call_api_to_create_member, lambda { |params|
    begin
      result = HTTP.post("#{FuturesWeb.config.FUTURESDB_API}/member/create",
               json: {
                  name: params[:Member_name],
                  phone: params[:Member_phone],
                  email: params[:Member_email],
                  location: params[:Member_location],
                  work: params[:Member_work],
                  money: params[:Member_money],
                  current_level: params[:Member_current_level],
                  expect_level: params[:Member_expect_level],
                  time_join: params[:Member_time_join],
                  time_operate: params[:Member_time_operate] 
                })
      Right(result)
    rescue
      Left(Error.new('Input invalid, please provide the required information!'))
    end
  }

end

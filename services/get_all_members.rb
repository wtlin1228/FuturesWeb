# frozen_string_literal: true

# Gets list of all members from API
class GetAllMembers
  extend Dry::Monads::Either::Mixin

  def self.call
    results = HTTP.get("#{FuturesWeb.config.FUTURESDB_API}/member")
    Right(MembersRepresenter.new(Members.new).from_json(results.body))
  rescue
    Left(Error.new('Our servers failed - we are investigating!'))
  end
end

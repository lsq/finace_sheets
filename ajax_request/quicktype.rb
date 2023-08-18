# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   sponsor_org = SponsorOrg.from_json! "{…}"
#   puts sponsor_org.data&.data&.first.id.even?
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)
end

class Datum < Dry::Struct
  attribute :id,            Types::Integer.optional
  attribute :org_name,      Types::String.optional
  attribute :org_abbr_name, Types::String.optional
  attribute :aoi_date,      Types::String.optional.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      id:            d["id"],
      org_name:      d["orgName"],
      org_abbr_name: d["orgAbbrName"],
      aoi_date:      d["aoiDate"],
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "id"          => id,
      "orgName"     => org_name,
      "orgAbbrName" => org_abbr_name,
      "aoiDate"     => aoi_date,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class DataClass < Dry::Struct
  attribute :data, Types.Array(Datum).optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      data: d["data"]&.map { |x| Datum.from_dynamic!(x) },
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "data" => data&.map { |x| x.to_dynamic },
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class SponsorOrg < Dry::Struct
  attribute :success, Types::Bool.optional
  attribute :code,    Types::Integer.optional
  attribute :message, Types::String.optional
  attribute :data,    DataClass.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      success: d["success"],
      code:    d["code"],
      message: d["message"],
      data:    d["data"] ? DataClass.from_dynamic!(d["data"]) : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "success" => success,
      "code"    => code,
      "message" => message,
      "data"    => data&.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

sponsor_org = SponsorOrg.from_json! '{
    "success": true,
    "code": 20000,
    "message": "成功",
    "data": {
        "data": [
            {
                "id": 1,
                "orgName": "爱建证券有限责任公司",
                "orgAbbrName": "爱建证券",
                "aoiDate": "2023-08-18"
            },
            {
                "id": 2,
                "orgName": "安信证券股份有限公司",
                "orgAbbrName": "安信证券",
                "aoiDate": null
            }]}
    
}'
puts sponsor_org.data&.data&.first.id.even?
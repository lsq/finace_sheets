#!/bin/env ruby

require 'shale'
require 'pry'

class Address < Shale::Mapper
	attribute :city, Shale::Type::String
	attribute :street, Shale::Type::String
	attribute :zip, Shale::Type::String
end
class Person < Shale::Mapper
	attribute :first_name, Shale::Type::String
	attribute :last_name, Shale::Type::String
	attribute :age, Shale::Type::Integer
	attribute :married, Shale::Type::Boolean, default: -> {false}
	attribute :hobbies, Shale::Type::String, collection: true
	attribute :address, Address
end

person = Person.new(
	first_name: 'John',
	last_name: 'Doe',
	age: 50,
	hobbies: ['ping-pong', 'Mountain climbing', 'on foot'],
	address: Address.new(city: 'Florida', street:'Oxford Street', zip:'E1 6An')
)

#binding.pry

person1 = Person.from_json(<<-DATA)
{
  "first_name": "John",
  "last_name": "Doe",
  "age": 50,
  "married": false,
  "hobbies": ["Singing", "Dancing"],
  "address": {
    "city": "London",
    "street": "Oxford Street",
    "zip": "E1 6AN"
  }
}
DATA

puts person.address.city
puts person1.address.city

#require 'json'
#require 'dry-types'
#require 'dry-struct'

#module Types
#  include Dry.Types(default: :nominal)
#end

class Datum < Shale::Mapper
  attribute :id,            Shale::Type::Integer
  attribute :orgName,      Shale::Type::String
  attribute :orgAbbrName, Shale::Type::String
  attribute :aoiDate,      Shale::Type::String
end

class DataClass < Shale::Mapper
  attribute :data, Datum, collection: true
end

class SponsorOrg < Shale::Mapper
  attribute :success, Shale::Type::Boolean
  attribute :code,    Shale::Type::Integer
  attribute :message, Shale::Type::String
  attribute :data,    DataClass
end

sponsorOrg = SponsorOrg.from_json(<<-DATA)
{
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
            }
            ]
            }
    
}
DATA

puts sponsorOrg.message
sponsorOrg.data.data.each {|i| puts i.orgName}

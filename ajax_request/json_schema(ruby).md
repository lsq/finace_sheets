### Json schema implementations

https://json-schema.org/implementations.html#from-data

#### Validators
- JSI
JSON Schema Instantiation(gem)
- [JSONSchemer](https://github.com/davishmcclurg/json_schemer)
JSON Schema validator. Supports drafts 4, 6, and 7.
- json-schema-generator(gem)
#### Schema generators
- From code
- From data
Online (web tool)
* jsonschema.net - generates schemas from example data
* Liquid Online Tools - infer JSON Schema from sample JSON data
* quicktype.io - infer JSON Schema from samples, and generate TypeScript, C++, go, Java, C#, Swift, etc. types from JSON Schema
```json
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
            }]}
    
}
```
```ruby
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
end

class DataClass < Dry::Struct
  attribute :data, Types.Array(Datum).optional
end

class Temperatures < Dry::Struct
  attribute :success, Types::Bool.optional
  attribute :code,    Types::Integer.optional
  attribute :message, Types::String.optional
  attribute :data,    DataClass.optional
end

```
generate json schema as follow:
```json
{
    "$schema": "http://json-schema.org/draft-06/schema#",
    "$ref": "#/definitions/Temperatures",
    "definitions": {
        "Temperatures": {
            "type": "object",
            "additionalProperties": false,
            "properties": {
                "success": {
                    "type": "boolean"
                },
                "code": {
                    "type": "integer"
                },
                "message": {
                    "type": "string"
                },
                "data": {
                    "$ref": "#/definitions/Data"
                }
            },
            "required": [
                "code",
                "data",
                "message",
                "success"
            ],
            "title": "Temperatures"
        },
        "Data": {
            "type": "object",
            "additionalProperties": false,
            "properties": {
                "data": {
                    "type": "array",
                    "items": {
                        "$ref": "#/definitions/Datum"
                    }
                }
            },
            "required": [
                "data"
            ],
            "title": "Data"
        },
        "Datum": {
            "type": "object",
            "additionalProperties": false,
            "properties": {
                "id": {
                    "type": "integer"
                },
                "orgName": {
                    "type": "string"
                },
                "orgAbbrName": {
                    "type": "string"
                },
                "aoiDate": {
                    "anyOf": [
                        {
                            "type": "string",
                            "format": "date"
                        },
                        {
                            "type": "null"
                        }
                    ]
                }
            },
            "required": [
                "aoiDate",
                "id",
                "orgAbbrName",
                "orgName"
            ],
            "title": "Datum"
        }
    }
}
```
- From model

#### Ruby json model

##### Shale
generates Ruby models from a JSON schema supports Draft
https://github.com/kgiszczak/shale#converting-json-to-object

##### Ostruct
https://github.com/ruby/ostruct
##### Ofstruct

[GitHub - arturoherrero/ofstruct: OpenFastStruct is a data structure, similar to an OpenStruct but faster.](https://github.com/arturoherrero/ofstruct)

##### jtd-codegen https://github.com/jsontypedef/json-typedef-codegen
Generate code from JSON Typedef schemas

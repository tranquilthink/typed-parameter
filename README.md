# typed_parameter
Create typed parameter class using strong parameter in rails.
You can cleanup parameter code for permit in your controller and convert it to the type you want.
You can get your OpenAPI JSON for parameter schemas.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'typed-parameter'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install typed-parameter

## Usage

Example 1. Type convert
-----
~~~ruby
class UserCreateParams < TypedParamter::Base
  field :name, String
  field :age, Integer
  field :email, String
end
-----------------------------------------------
############
## before ##
############
# method for params
def user_create_params
  params.permit(:name, :age, :email)
end

# in action
def create
  raise UserAgeTooYoung if user_create_params[:age].to_i < 20 
  # You need to convert your parameter type
end

############
## after ###
############
# method for params
def user_create_params
  UserCreateParams.permit(params)
end

# in action
def create
  raise UserAgeTooYoung if user_create_params[:age] < 20 
  # paramters are converted as your type
end
~~~


Example 2. More Types
------
~~~ruby
class CustomParameter < TypedParameter::Base
  field :string_field, String
  field :integer_field, Integer
  field :float_field, Float
  field :date_field, Date
  field :datetime_field, DateTime
  field :boolean_field, Boolean
end

############
## before ##
############
def custom_params
  params.permit(
   :string_field,  # => is_a? String
   :integer_field, # => is_a? String. You need to &:to_i
   :fload_field,   # => is_a? String. You need to &:to_f
   :date_field,    # => is_a? String. You need to &:to_date
   :datetime_field # => is_a? String. You need to &:to_datetime
   :boolean_field  # => is_a? Boolean. If paramter is string (like "false") then String
  )
end

############
## after ##
############
def custom_params
  CustomParamter.permit(params)
end

custom_params[:string_field] # => is_a? String
custom_params[:integer_field] # => is_a? Integer
custom_params[:float_field] # => is_a? Float
custom_params[:date_field] # => is_a? Date
custom_params[:datetime_field] # => is_a? DateTime
custom_params[:boolean] # => is_a? Boolean, If parameter is string (like "false", "true" "False", "True") then convert true or false
~~~

Example 3. Enum & Required
---
~~~ruby
class EnumAndRequiredParameter < TypedParameter::base
  field :enum_field, Integer, enum: [10, 20, 30, 40]
  field :required_field, String, required: true
end

def enum_and_required_params
  EnumAndRequiredParameter.permit(params)
end

# If params[:enum_field] has 25 ( not in 10, 20, 30, 40)
# => ArgumentError, "enum_field must be in 10, 20, 30, 40"

# if params[:required_field] is Nil
# => ArgumentError, "required_field is required"
~~~

Example 4. array & nested parameters 
---
~~~ruby
class ParentParameter < TypedParameter::Base
  field :name, String
  field :integers, [Integer]
  field :child, ChildParameter
  field :childs, [ChildParamter]
end

class ChildParameter < TypedParameter::Base
  field :name, String
end


example_params = { 
  name: "Name", 
  integers: ['1','2','3','4'], 
  child: { name: "child" },
  childs: [ 
    { name: "child1", age: "10" },
    { name: "child2", age: "12" },
    { name: "child3", age: "15" }
  ]
}

def parent_and_childs_params
  ParentParameter.permit(example_params)
end

# Result
{
  name: "Name",
  integers: [1,2,3,4],
  child: { name: "child" },
  childs: [ 
    { name: "child1" },
    { name: "child2" },
    { name: "child3" }
  ]
}

~~~
Example 4. CustomType
------
If You want to use your custom type like Email, just create two file.
- your type file. like "Email"
- yout type constant. like "EmailConstrant"

~~~ruby
class Email
  def initialize(value)
    @email = value
  end
end

class EmailConstrant
 class << self
  EMAIL_REGREX = //

  # using convert value to your type
  def value(value)
    raise ArgumentError unless EMAIL_REGREX.match? value

    Email.new(value)
  end
 end
end

class EmailSwaggerType
  class << self
    def value
      { type: :string }
    end
  end
end

# Register your type to typed-parameter when application initialize.
TypedParameter::ParameterTypes.register Email
TypedParameter::Constants.register :Email, EmailConstrant
TypedParameter::Swagger::Types.register :Email, EmailSwaggerType
~~~

Example 5. Use Inline Block
------
You can use parameter class by block

~~~ruby
class BlockParameter < TypedParameter::Base
  field :some_object, Object do |i|
    i.field :name, String
    i.field :type, String
  end
  
  field :other_hash_list, [Hash] do |i|
    i.field :index, Integer
    i.field :value, Float
  end
end
~~~

Example 6. Swaggerize
------
With Rswag(https://github.com/rswag/rswag), you can swaggerize your parameter types.

~~~ruby
class SwaggerParameter < TypedParameter::Base
  field :string, String, enum: ["one", "two"], description: "String Field"
  field :integer, Integer, description: "Integer Field"
  field :ref_field, SwaggerRefParameter
end

class SwaggerRefParameter < TypedParameter::Base
  field :string, String, description: "Ref String Field"
end

SwaggerParameter.swagger_properties
# =>
# { 
#  string: { type: :string, enum: ["one", "two" ], description: "String Field" }, 
#  integer: { type: :integer, description: "Integer Field" },
#  ref_field: { "$ref": "#/components/schemas/SwaggerRefParamter" }
# }
# 

# Add Components in your swagger
# in swagger_helper
components = TypedParameter::Swagger::ComponentGenerator.generate_all!

config.swagger_docs = {
    'v1/swagger.yaml' => {
      openapi:    '3.0.1',
      # ..., 
      components: {
        schemas: {
          **components
        }
      }
      #...
    }
  }
~~~
...


## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/typed-parameter.


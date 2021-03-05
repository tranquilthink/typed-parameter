require File.expand_path("#{File.dirname(__FILE__)}/spec_helper")

describe 'TypedParamter::Base' do
  it 'should autoload everything' do
    expect(defined?(TypedParameter::Base)).to eq 'constant'
    expect(defined?(TypedParameter::Constraints)).to eq 'constant'
    expect(defined?(TypedParameter::EnumConstraint)).to eq 'constant'
    expect(defined?(TypedParameter::TypeConstraint)).to eq 'constant'
    expect(defined?(TypedParameter::ParameterTypes)).to eq 'constant'
    expect(defined?(TypedParameter::PermitFieldGenerator)).to eq 'constant'

    expect(defined?(TypedParameter::Swagger::Types)).to eq 'constant'
    expect(defined?(TypedParameter::Swagger::TypeGenerator)).to eq 'constant'
    expect(defined?(TypedParameter::Swagger::PropertyGenerator)).to eq 'constant'
    expect(defined?(TypedParameter::Swagger::ComponentGenerator)).to eq 'constant'
  end
end

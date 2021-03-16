require File.expand_path("#{File.dirname(__FILE__)}/spec_helper")

class TodoCreateParameter < TypedParameter::Base
  field :content, String, required: true
  field :done, Boolean, required: true
  field :user_id, Integer, required: true
  field :due_date, Date, required: true
end

describe 'TodoCreateParameter' do
  it 'has content and done fields' do
    expect(TodoCreateParameter.constraints.map(&:first)).to eq %i[content done user_id due_date]
  end

  it 'has swagger properties' do
    expect(TodoCreateParameter.swagger_properties).to eq(
      {
        content:  { type: :string },
        done:     { type: :boolean },
        user_id:  { type: :integer },
        due_date: { type: :string, format: :date }
      }
    )
  end

  it 'has required properties' do
    expect(TodoCreateParameter.swagger_requirements).to eq(%i[content done user_id due_date])
  end

  it 'constraint type to parameters' do
    params = ActionController::Parameters.new({
                                                content:  'TEST',
                                                done:     'false',
                                                user_id:  '3',
                                                due_date: '2021-03-06 00:40:35.450901 +0900'
                                              })

    expect(params.permit(:content)[:content]).to eq 'TEST'
    expect(params.permit(:done)[:done]).to eq 'false'
    expect(params.permit(:user_id)[:user_id]).to eq '3'
    expect(params.permit(:due_date)[:due_date].class).to eq String

    expect(TodoCreateParameter.permit(params)[:content]).to eq 'TEST'
    expect(TodoCreateParameter.permit(params)[:done]).to eq false
    expect(TodoCreateParameter.permit(params)[:user_id]).to eq 3
    expect(TodoCreateParameter.permit(params)[:due_date].class).to eq Date
  end
end

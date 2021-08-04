require "rails_helper"

RSpec.describe Types::TodoType do
  set_graphql_type

  it "has the correct field types" do
    expect(subject.fields["id"].type.to_type_signature).to eq("ID!")
    expect(subject.fields["title"].type.to_type_signature).to eq("String!")
    expect(subject.fields["description"].type.to_type_signature).to eq("String")
    expect(subject.fields["completed"].type.to_type_signature).to eq("Boolean!")
    expect(subject.fields["author"].type.to_type_signature).to eq("String!")
  end
end

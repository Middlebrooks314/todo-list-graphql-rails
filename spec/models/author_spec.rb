require "rails_helper"

RSpec.describe Author, type: :model do
  subject do
    described_class.new(
      name: "Foo"
    )
  end

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "can be created with a name" do
    subject.name = "Bar"
    expect(subject).to be_valid
  end
end

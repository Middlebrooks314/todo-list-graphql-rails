require "rails_helper"

RSpec.describe Todo, type: :model do
  subject do
    described_class.new(
      title: "Make the bed",
      description: "Be able to bounce a quarter.",
      completed: true,
      author: "Bugs Bunny"
    )
  end

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a title" do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a completion status" do
    subject.completed = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without an author" do
    subject.author = nil
    expect(subject).to_not be_valid
  end

  it "can be created without a description" do
    subject.description = nil
    expect(subject).to be_valid
  end
end

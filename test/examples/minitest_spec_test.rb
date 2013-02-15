require "minitest/spec"
require "minitest/autorun"

describe "a thing" do
  it "goes up" do
    assert true
  end

  it "goes down" do
  end

  describe "when jumping" do
    it "explodes" do
      flunk
    end

    it "is happy" do
    end
  end

  describe "non nested" do
    it "doesn't include when jumping" do
    end
  end

  SomeClass = Class.new

  describe SomeClass do
    it "works" do
    end
  end
end

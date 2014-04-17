require 'minitest/autorun'

describe "A labrat" do
  it "has binding information" do
    assert LabRat.get_binding.kind_of?(Binding)
  end

  it "is a class" do
    assert LabRat.kind_of?(Class)
  end
end

require 'minitest/autorun'

describe "A unique name" do
  it "is in fact unique" do
    names = {}
    20.times{ names[get_unique_name] = 1 }
    assert names.keys.length == 20
  end
end

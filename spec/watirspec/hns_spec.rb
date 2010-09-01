# encoding: utf-8
require File.expand_path('spec_helper', File.dirname(__FILE__))

describe "H1s", "H2s", "H3s", "H4s", "H5s", "H6s" do
  before :each do
    browser.goto(WatirSpec.files + "/non_control_elements.html")
  end

  describe "with selectors" do
    it "returns the matching elements" do
      browser.h1s(:class => "primary").to_a.should == [browser.h1(:class => "primary")]
    end
  end

  describe "#length" do
    it "returns the number of h1s" do
      browser.h2s.length.should == 9
    end
  end

  describe "#[]" do
    it "returns the h1 at the given index" do
      browser.h1s[0].id.should == "first_header"
    end
  end

  describe "#each" do
    it "iterates through header collections correctly" do
      lengths = (1..6).collect do |i|
        collection = browser.send(:"h#{i}s")
        collection.each_with_index do |h, index|
          h.id.should == browser.send(:"h#{i}", :index, index).id
          h.value.should == browser.send(:"h#{i}", :index, index).value
        end
        collection.length
      end
      lengths.should == [2, 9, 2, 1, 1, 2]
    end
  end
end

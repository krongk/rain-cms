require "spec_helper"

describe Admin::ForagesController do
  describe "routing" do

    it "routes to #index" do
      get("/admin/forages").should route_to("admin/forages#index")
    end

    it "routes to #new" do
      get("/admin/forages/new").should route_to("admin/forages#new")
    end

    it "routes to #show" do
      get("/admin/forages/1").should route_to("admin/forages#show", :id => "1")
    end

    it "routes to #edit" do
      get("/admin/forages/1/edit").should route_to("admin/forages#edit", :id => "1")
    end

    it "routes to #create" do
      post("/admin/forages").should route_to("admin/forages#create")
    end

    it "routes to #update" do
      put("/admin/forages/1").should route_to("admin/forages#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/admin/forages/1").should route_to("admin/forages#destroy", :id => "1")
    end

  end
end

require 'rails_helper'

RSpec.describe "Checks", type: :request do
    it "Render the checker view" do
        get "/checks"
        expect(response).to render_template(:show)
    end
    it "Made a check and be redirected to the show view" do
        post "/checks", :params => {
            :check => {
                private_number: "0000"
            },
            :authenticity_token => "UqvsEmLgKSxuFrPdr/0fYqJFYkkV3/V4m31Kb0TjtqNPsJKgH8K7mcC4/fgZql+pdtXrTBLtB9PKE4i3wzO88A==",
            :commit => "Check"
        }
        expect(response).to redirect_to(checks_path)
        follow_redirect!
        expect(response).to render_template(:show)
    end
end

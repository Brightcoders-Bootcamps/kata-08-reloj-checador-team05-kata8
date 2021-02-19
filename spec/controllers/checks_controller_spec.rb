RSpec.describe "Checks Controller" do
    before(:each) do 
        @check_ctrl = ChecksController.new
        @company_test = Company.create!({name: "Company tester", address: "Test address"})
        user = {name: "user test name", private_number: Time.now.to_i, email: "test@mail.com", enabled: 1, company_id: @company_test[:id]}
        @user_test = User.create!(user)
        @user_test_2 = User.create!(user)
    end
    it "Check if a user is not null" do
        result = @check_ctrl.send(:user?, true)
        expect(result).to eq(true)
    end
    it "A check is created" do 
        expect(@user_test.checks.create({type_check: 1}).is_a? Check).to eq(true)
    end
    it "Get the user check type" do
        type_check = @check_ctrl.send(:get_type_check, @user_test_2[:id])
        expect(type_check).to eq(1)
        @user_test_2.checks.create({type_check: type_check})
        type_check = @check_ctrl.send(:get_type_check, @user_test_2[:id])
        expect(type_check).to eq(2)
        @user_test_2.checks.create({type_check: type_check})
        type_check = @check_ctrl.send(:get_type_check, @user_test_2[:id])
        expect(type_check).to eq(:checked)
    end
end
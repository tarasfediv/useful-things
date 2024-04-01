# frozen_string_literal: true

RSpec.describe(UsersFinder) do
  describe "#call" do
    let_it_be(:org_admin) { create(:org_administrator, :as_active, first_name: "John", last_name: "Weak") }
    let_it_be(:translation_qa) { create(:translation_qa, :as_inactive, first_name: "Patrick", last_name: "Jane") }

    let(:current_user) { create(:administrator) }
    let(:finder_result) { described_class.call({ current_user: current_user }, params) }
    let(:params) do
      {}
    end

    it "returns only active users" do
      params[:active] = true

      expect(finder_result).to(contain_exactly(org_admin))
    end

    it "returns only users with requesting type" do
      params[:type] = "TranslationQa"

      expect(finder_result).to(contain_exactly(translation_qa))
    end

    it "returns users byt search terms" do
      params[:search] = "John"

      expect(finder_result).to(contain_exactly(org_admin))
    end

    it "returns users sorted by first name desc" do
      params[:sortings] = "first_name DESC"

      expect(finder_result).to(contain_exactly(translation_qa, org_admin))
    end
  end
end

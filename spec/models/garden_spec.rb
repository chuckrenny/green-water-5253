require "rails_helper"

RSpec.describe Garden, type: :model do
  before :each do
    @garden = Garden.create!(name: "Garden of Eden", organic: true)
    @plot1 = @garden.plots.create!(number: 1, size: 'Medium', direction: 'West')
    @plot2 = @garden.plots.create!(number: 2, size: 'Small', direction: 'North')

    @garden2 = Garden.create!(name: "Butterfly Garden", organic: true)
    @plot3 = @garden2.plots.create!(number: 3, size: 'Large', direction: 'South')

    @plant1 = Plant.create!(name: "Raspberry Bush", description: "Annual", days_to_harvest: 90)
    @plant2 = Plant.create!(name: "Blueberry Bush", description: "Quarterly", days_to_harvest: 100)
    @plant3 = Plant.create!(name: "Strawberry Bush", description: "Seasonal", days_to_harvest: 90)
    @plant4 = Plant.create!(name: "Strawberry Bush", description: "Seasonal ", days_to_harvest: 90)
    @plant5 = Plant.create!(name: "Gooseberry Bush", description: "Perennial", days_to_harvest: 70)
    @plant6 = Plant.create!(name: "Elderberry Bush", description: "Annual", days_to_harvest: 130)
    
    PlotPlant.create!(plot: @plot1, plant: @plant1)
    PlotPlant.create!(plot: @plot1, plant: @plant2)
    PlotPlant.create!(plot: @plot2, plant: @plant1)
    PlotPlant.create!(plot: @plot2, plant: @plant4)

    PlotPlant.create!(plot: @plot3, plant: @plant5)
    PlotPlant.create!(plot: @plot3, plant: @plant6)
  end

  describe 'relationships' do
    it { should have_many(:plots) }
  end

  describe "validations" do
    it { should validate_presence_of(:name)}
    it { should validate_presence_of(:organic)}
  end

  describe "instance methods" do
    describe "#unique_list_under_100" do
      it "returns a unique list of plants that harvest in less than 100 days" do
        expect(@garden.unique_list_under_100).to eq([@plant1.name, @plant3.name])
      end
    end
  end 
end
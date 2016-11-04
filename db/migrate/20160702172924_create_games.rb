class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|

      t.string :full
      t.string :season
      t.string :month
      t.string :day
      t.string :away_team
      t.string :home_team

      t.timestamps null: false
    end
  end
end

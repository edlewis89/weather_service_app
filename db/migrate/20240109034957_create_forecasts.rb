class CreateForecasts < ActiveRecord::Migration[7.1]
  def change
    create_table :forecasts do |t|
      t.string :zip_code
      t.text :data
      t.datetime :expires_at

      t.timestamps
    end
  end
end

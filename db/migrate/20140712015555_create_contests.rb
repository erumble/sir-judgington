class CreateContests < ActiveRecord::Migration
  def change
    create_table :contests do |t|
      t.date :date

      t.timestamps
    end
  end
end

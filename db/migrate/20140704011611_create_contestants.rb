class CreateContestants < ActiveRecord::Migration
  def change
    create_table :contestants do |t|
      t.string :first_name
      t.string :last_name
      t.string :phonetic_spelling
      t.string :email

      t.timestamps
    end
  end
end

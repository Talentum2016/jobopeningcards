class CreateJobopenings < ActiveRecord::Migration
  def change
    create_table :jobopenings do |t|
      t.string :tittle
      t.string :description
      t.attachment :image

      t.belongs_to :user, index:true
      t.belongs_to :profession, index:true
      t.timestamps null: false
      
    end
  end
end

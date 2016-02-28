class CreateProfessions < ActiveRecord::Migration
  def change
    create_table :professions do |t|
      t.string :title
      t.attachment :image_prof
      t.belongs_to :category, index:true
      t.timestamps null: false
    end
  end
end

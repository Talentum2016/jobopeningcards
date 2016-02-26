class CreateJobOpenings < ActiveRecord::Migration
  def change
    create_table :job_openings do |t|
      t.string :title
      t.string :description
      t.attachment :image
      t.string :requirement
      t.integer :salary_min
      t.integer :salary_max

      t.belongs_to :user, index:true
      t.belongs_to :profession, index:true
      t.timestamps null: false
      
    end
  end
end

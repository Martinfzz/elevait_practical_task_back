class CreateDocuments < ActiveRecord::Migration[6.1]
  def change
    create_table :documents do |t|
      t.string :title
      t.string :author
      t.datetime :dateCreated
      
      t.timestamps
    end
  end
end

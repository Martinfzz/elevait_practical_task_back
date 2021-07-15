class CreatePages < ActiveRecord::Migration[6.1]
  def change
    create_table :pages do |t|
      t.integer :pageNr
      t.string :text
      t.belongs_to :document, index: true
      
      t.timestamps
    end
  end
end

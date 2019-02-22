class AddSavedToCocktails < ActiveRecord::Migration[5.2]
  def change
    add_column :cocktails, :saved, :boolean
  end
end

class AddDescriptionToCocktails < ActiveRecord::Migration[5.2]
  def change
    add_column :cocktails, :description, :string
    add_column :cocktails, :image, :string
  end
end

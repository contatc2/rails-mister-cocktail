class RemoveImageFromCocktail < ActiveRecord::Migration[5.2]
  def change
    remove_column :cocktails, :image, :string
  end
end

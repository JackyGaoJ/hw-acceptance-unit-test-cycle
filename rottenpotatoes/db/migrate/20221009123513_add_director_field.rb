class AddDirectorField < ActiveRecord::Migration
  def change
    # Reference:
    # https://guides.rubyonrails.org/active_record_migrations.html
    add_column :movies, :director, :string
  end
end

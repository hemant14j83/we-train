class AddPaperclipToTrainer < ActiveRecord::Migration
  def change
	add_attachment :trainers, :image
  end
end

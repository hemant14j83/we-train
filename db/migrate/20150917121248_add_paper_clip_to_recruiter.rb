class AddPaperClipToRecruiter < ActiveRecord::Migration
  def change
	add_attachment :recruiters, :image
  end
end

class AddHstore < ActiveRecord::Migration  
  def up
    unless Rails.env.production?
      enable_extension :hstore
    end
  end

  def down
    unless Rails.env.production?
      disable_extension :hstore
    end
  end
end  

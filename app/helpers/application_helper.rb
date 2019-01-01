module ApplicationHelper
  def nav_show_game
    @game && @game.persisted?
  end

  def nav_new_aclass
    (@game && @game.new_record?) ? 'active' : ''
  end

  def nav_page_aclass(page)
    (action_name == page) ? 'active' : ''
  end
end

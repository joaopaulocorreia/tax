module ApplicationHelper
  def active_menu(name)
    name == controller_path ? "active" : nil
  end
end

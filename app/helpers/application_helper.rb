# frozen_string_literal: true

module ApplicationHelper
  def active_menu(name)
    name == controller_path ? 'active' : nil
  end
end

module AdminPageLayoutOverride
  def build_active_admin_head
    within super do
      render 'partials/custom_script_tags'
    end
  end
end

ActiveAdmin::Views::Pages::Base.send :prepend, AdminPageLayoutOverride

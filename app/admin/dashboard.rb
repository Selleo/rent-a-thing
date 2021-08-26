ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { "Admin panel - Rent A Thing" } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      h1 "dashboard"
    end
  end
end

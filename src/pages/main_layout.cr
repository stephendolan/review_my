abstract class MainLayout
  include Lucky::HTMLPage

  # 'needs current_user : User' makes it so that the current_user
  # is always required for pages using MainLayout
  needs current_user : User

  abstract def content
  abstract def page_title

  def page_title
    ""
  end

  def render
    html_doctype

    html lang: "en" do
      m Shared::LayoutHead, page_title: page_title, context: context

      body do
        m Shared::FlashMessages, context.flash
        render_signed_in_user
        content
      end
    end
  end

  private def render_signed_in_user
    text current_user.email
    text " - "
    link "Sign out", to: SignIns::Delete, flow_id: "sign-out-button"
  end
end

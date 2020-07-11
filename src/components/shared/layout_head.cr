class Shared::LayoutHead < BaseComponent
  needs page_title : String
  # This is used by the 'csrf_meta_tags' method
  needs context : HTTP::Server::Context

  def render
    head do
      utf8_charset
      title ["ReviewMy", (@page_title.empty? ? nil : @page_title)].compact.join(" - ")
      css_link asset("css/app.css"), data_turbolinks_track: "reload"

      # Set up page view tracking in production only
      if Lucky::Env.production?
        js_link src: "https://kindmetrics.io/js/track.js", defer: "true", data_domain: "reviewmy.email"
        js_link src: "https://instant.page/5.1.0", type: "module", integrity: "sha384-by67kQnR+pyfy8yWP4kPO12fHKRLHZPfEsiSXR8u2IKcTdxD805MGUXBzVPnkLHw"
      end

      js_link asset("js/app.js"), defer: "true", data_turbolinks_track: "reload"
      js_link src: "https://kit.fontawesome.com/5360e87fe2.js", crossorigin: "anonymous"
      meta name: "turbolinks-cache-control", content: "no-cache"
      meta name: "description", content: site_description
      meta name: "robots", content: "index, follow"
      csrf_meta_tags
      responsive_meta_tag
    end
  end

  private def site_description
    "Review My Email provides quick and easy revisions to be requested from coworkers, friends, and family. Always send emails with the confidence that you're hitting the mark."
  end
end

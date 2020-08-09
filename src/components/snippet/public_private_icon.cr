class Snippet::PublicPrivateIcon < BaseComponent
  needs snippet : Snippet

  def render
    if snippet.domain_restricted?
      i class: "fas fa-lock #{icon_color} #{icon_padding}", title: "Locked to domain"
    else
      i class: "fas fa-lock-open text-indigo-600 p-0.5", title: "Public"
    end
  end

  private def icon_color
    "text-indigo-600"
  end

  private def icon_padding
    "p-0.5"
  end
end

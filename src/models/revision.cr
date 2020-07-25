class Revision < BaseModel
  table do
    belongs_to snippet : Snippet
    column content : String
    column creator_name : String?
    belongs_to creator : User?
  end

  def author : String
    if (user = creator)
      user.email
    else
      creator_name || "Anonymous"
    end
  end
end

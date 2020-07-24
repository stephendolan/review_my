class Snippets::Create < BrowserAction
  route do
    SaveSnippet.create(params, current_user: current_user) do |operation, snippet|
      if snippet
        redirect to: Dashboard::Index
      else
        html Snippets::NewPage, save_snippet: operation
      end
    end
  end
end

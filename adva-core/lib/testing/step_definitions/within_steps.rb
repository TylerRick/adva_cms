# http://mislav.uniqpath.com/2010/09/cuking-it-right/

# Then I should see "foo" in the top menu

scopes = {
  'in the title' => 'h1, h2, h3',
  'in the top menu' => '#top',
  'in the action menu' => '#actions',
  'in the sidebar' => '#sidebar'
}
scopes.each do |within, selector|
  Then /^(.+) #{within}$/ do |step|
    within(selector) do
      Then step
    end
  end
end

require "bundler/organization_audit/repo"

token = ARGV[0]

repos = Bundler::OrganizationAudit::Repo.all(:organization => "zendesk", :token => token)
puts "#{repos.size} repos"

names = repos.select do |repo|
  puts repo.project
  content = repo.content(".travis.yml") rescue nil
  puts content
  content.to_s[/code_climate/]
end.map(&:project)

puts names

require "bundler/organization_audit/repo"

org = ARGV[0] || raise('need org as first argument')
token = ARGV[1] || raise('need github token as second argument')

repos = Bundler::OrganizationAudit::Repo.all(organization: org, token: token)
puts "#{repos.size} repos"

repos = repos.map do |repo|
  begin
    next unless content = repo.content("Dockerfile.build")
    puts "FOUND #{repo.project}\n#{content}"
    [repo.project, content]
  rescue
    puts "ERROR #{repo.project} #{$!}"
  end
end.compact

puts repos.size

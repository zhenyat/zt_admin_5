################################################################################
#   Git versions: to be used for debugging in views
#
#   source:
#     http://stackoverflow.com/questions/4329816/rails-3-app-how-to-get-git-version-and-update-website
#
#   07.12.2014  ZT
#   08.12.2014  Last update (GIT_COMMIT_TIMESTAMP)
#   15.05.2015  Update for non-development environment
#   02.08.2016  Git verification added
#   18.11.2016  Deleting \n from GIT_BRANCH for better debugging format
################################################################################
if Rails.env.development?
  if File.directory?('.git')
    GIT_BRANCH           = `git symbolic-ref HEAD 2>/dev/null | cut -d"/" -f 3`.delete!("\n")
    GIT_COMMIT           = `git log --pretty=format:'%h' -n 1`
    GIT_COMMIT_TIMESTAMP = Time.at `git log --pretty=format:'%ct' -n 1`.to_i
  else
    GIT_BRANCH = ''
  end
end
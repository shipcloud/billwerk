# frozen_string_literal: true

require "thor"
require "json"
require "git"

class Release < Thor
  include Thor::Actions

  BASE_BRANCH = "chore/deployment"

  def self.exit_on_failure?
    true
  end

  desc "new", "Create new Version"
  option :push, type: :boolean, default: false, aliases: :p
  def new(major = nil)
    check_for_base_branch

    check_for_changes

    if major.nil?
      run("yarn run standard-version")
    else
      run("yarn run standard-version --release-as major")
    end

    bump_version

    run("thor release:push") if options[:push]
  end

  desc "push", "Push new Version"
  def push
    puts "Pushing new Version"

    run("git push origin #{BASE_BRANCH} --tags --no-verify")
    run("git push origin #{BASE_BRANCH} --no-verify", capture: true) # push your changes to update your local state
  end

  no_commands do
    private def check_for_base_branch
      if git.current_branch != BASE_BRANCH
        raise Thor::Error, "Please switch to the base branch #{BASE_BRANCH}"
      end
    end

    private def check_for_changes
      no_changes = (%i[deleted added changed untracked].all? do |status|
        git.status.send(status).nil? || git.status.send(status).empty?
      end)

      return if no_changes

      raise Thor::Error,
            "There are unstaged changes! Please commit or remove them before continuing"
    end

    private def git
      @_git ||= Git.open("#{__dir__}/../..")
    end

    private def versions
      load version_file
      package_data = JSON.parse(File.read(package_file))

      current_version = PactasItero::VERSION
      next_version = package_data["version"]

      [current_version, next_version]
    end

    private def update_version_file
      current_version, next_version = versions

      content = File.read(version_file)
      File.open(version_file, "w") do |file|
        new_content = content.gsub(current_version, next_version)
        file.write(new_content)
      end

      next_version
    end

    private def version_file
      "lib/pactas_itero/version.rb"
    end

    private def changelog_file
      "CHANGELOG.md"
    end

    private def package_file
      "package.json"
    end

    private def bump_version
      puts "Create new Version"

      next_version = update_version_file

      run("git add #{version_file}")
      run("git add #{changelog_file}")
      run("git add #{package_file}")
      run("git commit -m 'release: new Version #{next_version}' --no-verify")
      run("git tag #{next_version} -m 'Release #{next_version}'")
    end
  end
end

#/usr/bin/env ruby
#
# This file is part of zishamnium. Copyright (C) 2013 and above Shogun <shogun@cowtech.it>.
# Licensed under the MIT license, which can be found at http://www.opensource.org/licenses/mit-license.php.
#

require "open-uri"

home = ENV["HOME"]
root = "#{home}/.zishamnium"
ohmyzsh = "#{home}/.oh-my-zsh/"
contents_directory = File.dirname(__FILE__)
quiet = (ENV["ZISHAMNIUM_QUIET"] =~ /^(1|on|true|yes|t|y)$/i)
external_scripts = {
	"bashmarks" => ["71_bashmark", "https://raw.github.com/parroty/bashmarks/master/bashmarks.sh"],
	"git-completion" => ["72_git_completion", "https://raw.github.com/git/git/master/contrib/completion/git-completion.bash"]
}

desc "Installs the environment."
task :install do
	files = FileList["plugin.zsh", "theme.zsh-theme", "modules"]
	FileUtils.mkdir_p(root, :verbose => !quiet)
	FileUtils.mkdir_p("#{ohmyzsh}/custom/plugins/zishamnium/", :verbose => !quiet)
	FileUtils.mkdir_p("#{ohmyzsh}/themes/", :verbose => !quiet)
	FileUtils.cp_r(files, "#{root}/", :verbose => !quiet)
	FileUtils.chmod_R(0755, FileList[root], :verbose => !quiet)

	# Add symlinks 
	FileUtils.ln_sf("#{root}/plugin.zsh", "#{ohmyzsh}/custom/plugins/zishamnium/zishamnium.plugin.zsh", :verbose => !quiet)
	FileUtils.ln_sf("#{root}/theme.zsh-theme", "#{ohmyzsh}/themes/zishamnium.zsh-theme", :verbose => !quiet)

	puts "zishamnium plugin and theme have been installed. Enabling plugin and theme is left to you. Enjoy! ;)"
end

desc "Uninstalls the environment."
task :uninstall do
	FileUtils.rm_r(FileList[root, "#{ohmyzsh}/custom/plugins/zishamnium", "#{ohmyzsh}/themes/zishamnium.zsh-theme"], :verbose => !quiet)
	puts "zishamnium plugin and theme have been installed. Disabling plugin and theme is left to you. Farewell! ;)"
end

namespace :external do
	desc "Updates an external script."
	task :update, :name do |_, args|
		script_arg = args[:name].to_s

		raise RuntimeError.new("You have to specify the name of script to update. Valid scripts are: #{external_scripts.keys.join(", ")}.") if script_arg.strip.length == 0
		raise RuntimeError.new("External script #{script_arg} is not valid. Valid scripts are: #{external_scripts.keys.join(", ")}.") if !external_scripts[script_arg]
		final_script = external_scripts[script_arg]	

		open(contents_directory + "/modules/#{final_script[0]}.zsh", "w", 0755) do |destination|
			open(final_script[1]) do |source|
				destination.write(source.read)
			end
		end
	end
end

namespace :site do
	desc "Updates site installer."
	task :update_installer do
                system("git branch -D gh-pages")
                system("git fetch")
		system("git checkout gh-pages")
		system("curl -s -o installer https://raw.github.com/ShogunPanda/zishamnium/master/installer && git commit -qam \"Updated site installer.\" && git push -q")
		system("git branch -D gh-pages")
		system("git checkout master")
	end
end

task :default => ["install"]

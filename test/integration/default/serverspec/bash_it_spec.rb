require 'spec_helper'

describe file("#{Dir.home}/.bash_it") do
  it { should exist }
  it { should be_directory }
end

describe file("#{Dir.home}/.bash_it/completion/enabled") do
  it { should exist }
  it { should be_directory }
end

describe file("#{Dir.home}/.bash_it/aliases/enabled") do
  it { should exist }
  it { should be_directory }
end

describe file("#{Dir.home}/.bash_it/plugins/enabled") do
  it { should exist }
  it { should be_directory }
end

if os[:family] != 'darwin'
  describe file("#{Dir.home}/.bashrc") do
    it { should be_file }
    its(:content) { should include "export BASH_IT=" }
    its(:content) { should include "export BASH_IT_THEME=" }
    its(:content) { should include "source $BASH_IT/bash_it.sh" }
  end
end

describe command("/bin/bash -i -l -c reload") do
  its(:stderr) { should_not include "command not found" }
  its(:exit_status) { should eq 0 }
end

describe command("/bin/bash -i -l -c \"bash-it enable plugin git\"") do
  its(:stdout) { should include "git enabled" }
  its(:exit_status) { should eq 0 }
end

describe command("/bin/bash -i -l -c \"echo y | bash-it disable plugin git\"") do
  its(:stdout) { should include "git disabled" }
  its(:exit_status) { should eq 0 }
end

describe command("echo $SHELL") do
  its(:stdout) { should include "bash" }
  its(:exit_status) { should eq 0 }
end

describe file("#{Dir.home}/.bash_it/aliases/enabled/general.aliases.bash") do
  it { should exist }
  it { should be_symlink }
end

describe file("#{Dir.home}/.bash_it/aliases/enabled/ansible.aliases.bash") do
  it { should exist }
  it { should be_symlink }
end

describe file("#{Dir.home}/.bash_it/plugins/enabled/history.plugin.bash") do
  it { should exist }
  it { should be_symlink }
end

describe file("#{Dir.home}/.bash_it/completion/enabled/git.completion.bash") do
  it { should exist }
  it { should be_symlink }
end

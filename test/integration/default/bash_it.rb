describe file(".bash_it") do
  it { should exist }
  it { should be_directory }
end

describe file(".bash_it/completion/enabled") do
  it { should exist }
  it { should be_directory }
end

describe file(".bash_it/aliases/enabled") do
  it { should exist }
  it { should be_directory }
end

describe file(".bash_it/plugins/enabled") do
  it { should exist }
  it { should be_directory }
end

describe file(".bashrc") do
  it { should be_file }
  its(:content) { should include "export BASH_IT=" }
  its(:content) { should include "export BASH_IT_THEME=" }
  its(:content) { should include "source $BASH_IT/bash_it.sh" }
end

describe command("/bin/bash -i -l -c reload_aliases") do
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

describe bash("compgen -G .bash_it/enabled/*ansible.aliases.bash") do
  its(:stdout) { should include "ansible.aliases.bash" }
  its(:exit_status) { should eq 0 }
end

describe bash("compgen -G .bash_it/enabled/*history.plugin.bash") do
  its(:stdout) { should include "history.plugin.bash" }
  its(:exit_status) { should eq 0 }
end

describe bash("compgen -G .bash_it/enabled/*git.completion.bash") do
  its(:stdout) { should include "git.completion.bash" }
  its(:exit_status) { should eq 0 }
end

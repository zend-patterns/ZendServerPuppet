require 'facter'

# Default for non-Linux nodes
#
Facter.add(:my_script_value) do
    setcode do
        nil
    end
end

# Linux
#
Facter.add(:my_script_value) do
    confine :kernel  => :linux
    setcode do
        Facter::Util::Resolution.exec("echo 'gggggggggggg'")
    end
end
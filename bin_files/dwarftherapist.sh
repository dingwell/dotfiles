#!/bin/bash
echo "dwarftherapist WRAPPER (~/bin/dwarf_therapist)"

echo "Enable ptrace? (allows dwarftherapist to acces memory of df without root"
echo "privileges, (root permission will not be given to dwarftherapist)"
echo "If yes, please enter sudo password"
echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope || exit
sudo -k # disable super-user privileges
echo "ptrace enabled, (also disabled temporary root privileges)"
/usr/bin/dwarftherapist
echo "Disable ptrace? (recommended since dwarftherapist is no longer running)"
echo "If yes, please enter sudo password"
echo 1 | sudo tee /proc/sys/kernel/yama/ptrace_scope || exit
sudo -k
echo "ptrace disabled, (also disabled temporary root privileges)"

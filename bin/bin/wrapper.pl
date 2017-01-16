#!/usr/bin/env perl
# vim:ts=4:sw=4:expandtab
# © 2012 Michael Stapelberg, Public Domain

# This script is a simple wrapper which prefixes each i3status line with custom
# information. To use it, ensure your ~/.i3status.conf contains this line:
#     output_format = "i3bar"
# in the 'general' section.
# Then, in your ~/.i3/config, use:
#     status_command i3status | ~/i3status/contrib/wrapper.pl
# In the 'bar' section.

use strict;
use warnings;
# You can install the JSON module with 'cpan JSON' or by using your
# distribution’s package management system, for example apt-get install
# libjson-perl on Debian/Ubuntu.
use JSON;
use BSD::Sysctl 'sysctl';
use POSIX;

# Don’t buffer any output.
$| = 1;

# Skip the first line which contains the version header.
print scalar <STDIN>;

# The second line contains the start of the infinite array.
print scalar <STDIN>;

# Read lines forever, ignore a comma at the beginning if it exists.
while (my ($statusline) = (<STDIN> =~ /^,?(.*)/)) {
    my $battery_percentage = sysctl('hw.acpi.battery.life');
    my $battery_symbol = (sysctl('hw.acpi.battery.state') == 2) ? "\x{f1e6}" : chr(hex("0xf" . (244 - ceil($battery_percentage / 25))));
    my $battery_minutes = sysctl('hw.acpi.battery.time');
    my $brightness = sysctl('hw.acpi.video.lcd0.brightness');
    # Decode the JSON-encoded line.
    my @blocks = @{decode_json($statusline)};

    # Prefix our own information (you could also suffix or insert in the
    # middle).
    splice @blocks, 6, 0, ({
        full_text => sprintf("%s %d%% %02d:%02d",
                             $battery_symbol,
                             $battery_percentage,
                             ($battery_minutes > 0 ? ($battery_minutes / 60) % 24 : 0),
                             ($battery_minutes > 0 ? $battery_minutes % 60 : 0)),
        name => 'battery'
    },
    {
        full_text => "\x{f185} $brightness%",
        name => 'brightness'
    });

    # Output the line as JSON.
    print encode_json(\@blocks) . ",\n";
}

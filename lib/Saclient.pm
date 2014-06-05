package Saclient;
use 5.008005;
use strict;
use warnings;

our $VERSION = "0.01";



1;
__END__

=encoding utf-8

=head1 NAME

Saclient - An easy interface to control your resources on SAKURA Cloud.

=head1 SYNOPSIS

    use Saclient::Cloud::API;
    my $api = Saclient::Cloud::API->authorize($YOUR_API_TOKEN, $YOUR_API_SECRET);

    # To access resources in the specified zone
    my $api_is1b = $api->in_zone("is1b");

    # ...

=head1 DESCRIPTION

How to run the sample code:

    git clone git@github.com:sakura-internet/saclient.perl.git
    cd saclient.perl
    cp config.sample.sh config.sh
    vi config.sh
    ./test.sh

First, copy "config.sample.sh" file to "config.sh" and edit it.
You have to replace values defined in this script with your API token and secret.
These can be generated by "(Account Name) > Settings > API key" page in the control panel.

After that, just run "test.sh".

=head1 LICENSE

MIT License

=head1 AUTHOR

SAKURA Internet, Inc. E<lt>dev-support-ml@sakura.ad.jpE<gt>

=head1 COPYRIGHT

Copyright (C) 2014 SAKURA Internet, Inc.

=cut


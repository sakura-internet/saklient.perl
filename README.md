# NAME

Saklient - An easy interface to control your resources on SAKURA Cloud.

# SYNOPSIS

    use Saklient::Cloud::API;
    my $api = Saklient::Cloud::API->authorize($YOUR_API_TOKEN, $YOUR_API_SECRET);

    # To access resources in the specified zone
    my $api_is1b = $api->in_zone("is1b");

    # ...

# DESCRIPTION

## INSTALLATION

    # Install dependent packages
    yum install make git openssl-devel cpan
    # or
    apt-get install make git libssl-dev
    
    # Install cpanminus (if not yet)
    curl -L http://cpanmin.us | perl - App::cpanminus
    
    # Install Saklient module by cpanminus
    cpanm git@github.com:sakura-internet/saklient.perl.git

## EXAMPLES

Code examples are available at http://sakura-internet.github.io/saklient.doc/

# LICENSE

MIT License

# AUTHOR

SAKURA Internet, Inc. <dev-support-ml@sakura.ad.jp>

# COPYRIGHT

Copyright (C) 2014 SAKURA Internet, Inc.

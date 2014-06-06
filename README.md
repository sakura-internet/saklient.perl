# NAME

Saclient - An easy interface to control your resources on SAKURA Cloud.

# SYNOPSIS

    use Saclient::Cloud::API;
    my $api = Saclient::Cloud::API->authorize($YOUR_API_TOKEN, $YOUR_API_SECRET);

    # To access resources in the specified zone
    my $api_is1b = $api->in_zone("is1b");

    # ...

# DESCRIPTION

## INSTALLATION

    # Install dependent packages
    yum install make git openssl-devel
    # or
    apt-get install make git libssl-dev
    
    # Install cpanminus (if not yet)
    curl -L http://cpanmin.us | perl - App::cpanminus
    
    # Install Saclient module by cpanminus
    cpanm git@github.com:sakura-internet/saclient.perl.git

## HOW TO RUN THE SAMPLE CODE

    git clone git@github.com:sakura-internet/saclient.perl.git
    cd saclient.perl
    cp config.sample.sh config.sh
    vi config.sh
    ./test.sh

First, copy **"config.sample.sh"** file to **"config.sh"** and edit it.
You have to replace values defined in this script with your API token and secret.
These can be generated by **"(Account Name) ** Settings > API key"> page in the control panel.

After that, just run **"test.sh"**.

# LICENSE

MIT License

# AUTHOR

SAKURA Internet, Inc. <dev-support-ml@sakura.ad.jp>

# COPYRIGHT

Copyright (C) 2014 SAKURA Internet, Inc.

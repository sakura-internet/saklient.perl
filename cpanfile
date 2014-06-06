requires 'perl', '5.008008';
requires 'Error', '>=0.17022';
requires 'JSON', '>=2.53';
requires 'HTTP::Request', '>=6.00';
requires 'Crypt::SSLeay', '>=0.72';
requires 'LWP::UserAgent', '>=6.04';
requires 'URI::Escape', '>=3.28';
requires 'DateTime::Format::Strptime', '>=1.54';


on 'test' => sub {
    requires 'Test::More', '0.98';
};

on 'develop' => sub {
    requires 'Software::License';
};


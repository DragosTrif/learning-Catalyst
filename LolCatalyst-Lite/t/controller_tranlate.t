use strict;
use warnings;

use Test::More qw(no_plan);
use HTTP::Request::Common;
use lib 'lib';

BEGIN {use_ok 'Catalyst::Test', 'LolCatalyst::Lite'};

my ($request, $response);

$request = POST(
  'http://localhost/translate',
  'Content-Type' => 'form-data',
  'Content' => ['lol' => 'Can i have a cheese burger?'],
);

ok($response = request($request), 'Response');
ok($response->is_success, 'Resonse succsefull 2xx');
is($response->content_type, 'text/html', 'Response content type');
like($response->content, qr/CHEEZ/, 'contains the translate string');
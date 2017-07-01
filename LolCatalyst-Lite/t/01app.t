#!/usr/bin/env perl
use strict;
use warnings;
use Test::More 'no_plan';
use lib 'lib';
#use Catalyst::Test 'LolCatalyst::Lite';
#use LolCatalyst::Lite;

BEGIN { use_ok 'Catalyst::Test', 'LolCatalyst::Lite' };
use HTTP::Headers;
use HTTP::Request::Common;

# # get request
my $request = GET('http://localhost');
my $response = request($request);
ok($response = request($request), 'Basic request');
ok($response->is_success, "Start request to start the page");
# test request to translate
$request = POST(
  'http://localhost/translate',
  'Contet-type' => 'form-data',
  'Content' => ['lol' => 'Can i have a chessburger ?'],
);

$response = undef;
ok($response = request($request), 'Request to return translation');
ok($response->is_success, 'Translation request succesfull');
is($response->content_type, 'text/html', 'Html contet type');
like($response->content, qr/CHESS/, "Contains a correct translation snippet");

# test request to translate
$request = POST(
  'http://localhost/translate_service',
  'Contet-type' => 'form-data',
  'Content' => ['lol' => 'Can i have a chessburger ?'],
);
$request->headers->authorization_basic('fred', 'wilma');
$response = undef;
ok($response = request($request), 'Request to return Json');
diag($response);
ok($response->is_success, 'Translation request succesfull');
is($response->content_type, 'application/json', 'Json contet type');
like($response->content, qr/CHESS/, "Contains a correct translation snippet");

# # ok( request('/')->is_success, 'Request should succeed' );

done_testing();

use strict;
use warnings;
use lib 'lib';

use Test::More 'no_plan';
use LolCatalyst::Lite::Translator;
my $str = LolCatalyst::Lite::Translator->new();
ok($str, 'Constructed object ok');
like($str->translate('Can i have a chessburger?'), qr/CHEZZ/, 'STRING TRANSLATED OK');
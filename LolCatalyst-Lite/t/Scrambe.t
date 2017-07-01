use strict;
use warnings;
use lib 'lib';
use Test::More 'no_plan';
use LolCatalyst::Lite::Translator;
use Data::Dumper;

ok ((my $tr = LolCatalyst::Lite::Translator->new));

my $input = 'hello world';
my $scrambeld = $tr->translate_to("Scrambel", $input);

like ($scrambeld, qr/h...o w...d/, 'text matches first/last');
diag('my print');
diag($scrambeld);
diag(Dumper\$tr);
isnt ($scrambeld, $input, 'text alterd');
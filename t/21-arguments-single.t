# vim: filetype=perl :
use strict;
use warnings;

use Test::More import => ['!pass'];

plan tests => 4;

use Dancer ':syntax';
use Dancer::Test;

setting views    => path(qw( t views ));
#setting template => 'template_toolkit';
setting plugins => {
   FlashNote => {
      queue => 'single',
      arguments => 'single',
   },
};

use_ok 'Dancer::Plugin::FlashNote';

ok(get('/' => sub {
   flash(qw( whatever you do ));
   template single => {where => 'root'};
}),
   'root route');

route_exists [GET => '/'];

response_content_is([GET => '/'], "root: whatever\n");
use strict;
use warnings;

use PostgreSQL::Test::Cluster;
use Test::More tests => 2;

my $node = PostgreSQL::Test::Cluster->new('main');
$node->init;
$node->start;

$ENV{PGOPTIONS} = '-c gp_role=utility --client-min-messages=WARNING';

$node->issues_sql_like(
	[ 'reindexdb', '-a' ],
	qr/statement: REINDEX.*statement: REINDEX/s,
	'reindex all databases');
